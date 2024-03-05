import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location_repository/location_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:latlong2/latlong.dart';

//blocs
import '../presentation/blocs/gps/gps_bloc.dart';
//cubits
import '../presentation/cubits/login/login_cubit.dart';

//domain
import '../domain/abstracts/format_abstract.dart';
import '../domain/models/requests/login_request.dart';
import '../domain/repositories/api_repository.dart';
import '../domain/repositories/database_repository.dart';

//services
import '../locator.dart';
import '../presentation/widgets/global/app_map_sheet.dart';
import '../services/storage.dart';

class HelperFunctions with FormatDate {

  final LocalStorageService _storageService = locator<LocalStorageService>();
  final ApiRepository _apiRepository = locator<ApiRepository>();
  final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();
  final LocationRepository _locationRepository = locator<LocationRepository>();

  Future<Map<String, dynamic>?> getDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    const storage = FlutterSecureStorage();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var id = await storage.read(key: 'unique_id');
      var model = iosDeviceInfo.utsname.machine;
      if (id != null) {
        return {'id': id, 'model': model};
      } else {
        id = iosDeviceInfo.identifierForVendor!;
        await storage.write(key: 'unique_id', value: id);
        return {'id': id, 'model': model};
      }
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var id = await storage.read(key: 'unique_id');
      var model = androidDeviceInfo.model;
      if (id != null) {
        return {'id': id, 'model': model};
      } else {
        id = androidDeviceInfo.id;
        await storage.write(key: 'unique_id', value: id);
        return {'id': id, 'model': model};
      }
    }
    return null;
  }

  Future<void> login() async {
    var username = _storageService.getString('username');
    var password = _storageService.getString('password');

    var location = await _locationRepository.getCurrentLocation();
    var device = await getDevice();
    var version = "1.3.120+244";

    var response = await _apiRepository.login(
        request: LoginRequest(
            username!,
            password!,
            device!['id'],
            device['model'],
            version,
            now(),
            location.latitude.toString(),
            location.longitude.toString()));

    if (response is LoginSuccess) {
      final login = response.data!.login;
      _storageService.setString('token', login?.token);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> get _externalPath async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<Widget?> showMapDirection(BuildContext context, dynamic work,
      LatLng? location) async {
    final availableMaps = await MapLauncher.installedMaps;

    // TODO [Andres Cardenas] get one location ///TEST
    if(context.mounted) location ??= context.read<GpsBloc>().state.lastKnownLocation;

    if (availableMaps.length == 1) {
      await availableMaps.first.showDirections(
        destination: Coords(
          double.parse(work.latitude!),
          double.parse(work.longitude!),
        ),
        destinationTitle: work.customer,
        origin: Coords(location!.latitude, location.longitude),
        originTitle: 'Origen',
        waypoints: null,
        directionsMode: DirectionsMode.driving,
      );

      return null;
    } else {
      if (context.mounted) {
        return await AppGlobalMapsSheet.show(
            context: context,
            onMapTap: (map) {
              map.showDirections(
                destination: Coords(
                  double.parse(work.latitude!),
                  double.parse(work.longitude!),
                ),
                destinationTitle: work.customer,
                origin: Coords(location!.latitude, location.longitude),
                originTitle: 'Origen',
                waypoints: null,
                directionsMode: DirectionsMode.driving,
              );
            });
      } else {
        return null;
      }
    }
  }
}
