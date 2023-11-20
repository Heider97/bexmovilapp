import 'dart:io';

import 'package:bexmovil/src/core/abstracts/FormatAbstract.dart';
import 'package:bexmovil/src/domain/models/requests/login_request.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location_repository/location_repository.dart';
import 'package:path_provider/path_provider.dart';

//services
import '../locator.dart';
import '../services/storage.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final ApiRepository _apiRepository = locator<ApiRepository>();
final DatabaseRepository _databaseRepository = locator<DatabaseRepository>();
final LocationRepository _locationRepository = locator<LocationRepository>();

class HelperFunctions with FormatDate {
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

    var response = await _apiRepository.login(
        request: LoginRequest(
            username!,
            password!,
            device!['id'],
            device['model'],
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
}
