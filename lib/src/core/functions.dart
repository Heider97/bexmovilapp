import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:latlong2/latlong.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:yaml/yaml.dart';

//blocs
import '../domain/models/isolate.dart';
import '../domain/models/priority.dart';
import '../domain/models/processing_queue.dart';
import '../domain/models/requests/dynamic_request.dart';
import '../domain/models/responses/dynamic_response.dart';
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
import '../services/storage.dart';

//widgets
import '../presentation/widgets/atomsbox.dart';
import '../utils/resources/data_state.dart';

class HelperFunctions with FormatDate {

  final LocalStorageService storageService;
  final ApiRepository apiRepository;
  final DatabaseRepository databaseRepository;

  HelperFunctions({
      required this.storageService,
      required this.apiRepository,
      required this.databaseRepository
  });

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

  Future<void> login(BuildContext context) async {
    var username = storageService.getString('username');
    var password = storageService.getString('password');

    var location = await context.read<GpsBloc>().getCurrentLocation();
    var device = await getDevice();
    var yaml = loadYaml(await rootBundle.loadString('pubspec.yaml'));
    var version = yaml['version'];

    var response = await apiRepository.login(
        request: LoginRequest(
            username!,
            password!,
            device!['id'],
            device['model'],
            version,
            now(),
            location?.latitude.toString(),
            location?.longitude.toString()));

    if (response is LoginSuccess) {
      final login = response.data!.login;
      storageService.setString('token', login?.token);
    }
  }

  Future<void> runMigrations(List<Priority> priorities) async {
    var migrations = <String>[];
    for (var migration in priorities) {
      try {
        if (migration.schema != null) {
          String sqlScriptWithoutEscapes =
              migration.schema!.replaceAll(RegExp(r'\\r\\n|\r\n|\n|\r'), ' ');
          List<String> scriptsSeparated =
              sqlScriptWithoutEscapes.split('CREATE');
          for (String createTableScript in scriptsSeparated) {
            try {
              String scriptCompleted =
                  'CREATE $createTableScript'.replaceAll(';', '');
              migrations.add(scriptCompleted);
            } catch (ex) {
              print('Error al ejecutar el script:\n$ex');
            }
          }
        }
      } catch (ex) {
        print('Error $ex');
      }
    }
    migrations.removeWhere((element) => element == 'CREATE ');
    await databaseRepository.runMigrations(migrations);
  }

  Future<List<Future<dynamic>>> insertSyncPriorities(
      List<Priority> prioritiesSync) async {
    List<String> tables =
        prioritiesSync.map((priority) => priority.name).toList();

    List<List<String>> results = subdivideArray(tables, 5);

    List<Future<dynamic>> futureInserts = [];

    for (var result in results) {
      var response = await apiRepository.syncDynamicMultiTables(
          request: DynamicRequestMultitable(result));

      if (response is DataSuccess &&
          response.data != null &&
          response.data!.data != null) {
        for (var entry in response.data!.data!.entries) {
          futureInserts
              .add(databaseRepository.insertAll(entry.key, entry.value));
        }
      }
    }

    return futureInserts;
  }

  Future<void> insertAsyncPriorities(List<Priority> prioritiesAsync) async {
    var functions = <Function>[];
    var tables = <String>[];
    var arguments = <Map<String, dynamic>>[];

    for (var priority in prioritiesAsync) {
      tables.add(priority.name);
    }

    List<List<String>> results = subdivideArray(tables, 5);

    for (int i = 0; i < results.length; i++) {
      functions.add(insertDynamicData);
      arguments.add({'tables': results[i]});
    }

    var isolateModel = IsolateModel(functions, arguments, results.length);

    await heavyTask(isolateModel);
  }

  Future<void> insertDynamicData(List<String> tables) async {
    var processingQueue = ProcessingQueue(
        body: jsonEncode({'tables': tables}),
        task: 'incomplete',
        code: 'store_dynamic_data',
        createdAt: now(),
        updatedAt: now());

    // processingQueueBloc.addProcessingQueue(processingQueue);
  }

  Future<void> heavyTask(IsolateModel model) async {
    for (var i = 0; i < model.iteration; i++) {
      if (model.arguments![i].isNotEmpty) {
        await model.functions[i](model.arguments![i]['tables']);
      } else {
        await model.functions[i]();
      }
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

  Future<Widget?> showMapDirection(
      BuildContext context, dynamic work, LatLng? location) async {
    final availableMaps = await MapLauncher.installedMaps;

    // TODO [Andres Cardenas] get one location ///TEST
    if (context.mounted)
      location ??= context.read<GpsBloc>().state.lastKnownLocation;

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

  Future<void> launchWhatsApp(String phone, String message) async {
    try {
      final link = WhatsAppUnilink(
        phoneNumber: phone,
        text: message,
      );
      await FlutterWebBrowser.openWebPage(url: link.toString());
    } catch (e, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(e, stackTrace);
      return;
    }
  }

  Future<void> handleException(dynamic error, StackTrace stackTrace) async {
    // var errorData = Error(
    //   errorMessage: error.toString(),
    //   stackTrace: stackTrace.toString(),
    //   createdAt: now(),
    // );
    // await _databaseRepository.insertError(errorData);
    await FirebaseCrashlytics.instance.recordError(error, stackTrace);
  }

  List<List<String>> subdivideArray(List<String> array, int maxElements) {
    List<List<String>> subarrays = [];

    for (int i = 0; i < array.length; i += maxElements) {
      int fin =
          (i + maxElements < array.length) ? i + maxElements : array.length;
      subarrays.add(array.sublist(i, fin));
    }

    return subarrays;
  }
}
