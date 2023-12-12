import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location_repository/location_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//data
import 'core/cache/cache_manager.dart';
import 'core/cache/storage/cache_storage.dart';

import 'data/datasources/local/app_database.dart';
import 'data/datasources/remote/api_service.dart';
import 'data/repositories/api_repository_impl.dart';
import 'data/repositories/database_repository_impl.dart';

//domain
import 'domain/repositories/api_repository.dart';
import 'domain/repositories/database_repository.dart';

//services
import 'services/storage.dart';
import 'services/navigation.dart';
import 'services/platform.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies({ testing = false, Dio? dio }) async {
  if(testing) {
    final storage = await LocalStorageService.getInstance(testing: true);
    locator.registerSingleton<LocalStorageService>(storage!);

    final navigation = NavigationService();
    locator.registerSingleton<NavigationService>(navigation);

    final db = await AppDatabase().getInstance();
    locator.registerSingleton<AppDatabase>(db!);

    locator.registerSingleton<ApiService>(
      ApiService(testing: true, dio: dio!, storageService: locator<LocalStorageService>()),
    );

    locator.registerSingleton<ApiRepository>(
      ApiRepositoryImpl(locator<ApiService>()),
    );

    locator.registerSingleton<DatabaseRepository>(
      DatabaseRepositoryImpl(locator<AppDatabase>()),
    );

    locator.registerSingleton<LocationRepository>(
      LocationRepository(),
    );

  } else {
    final storage = await LocalStorageService.getInstance();
    locator.registerSingleton<LocalStorageService>(storage!);

    locator.registerSingleton<CacheManager>(CacheManager(CacheStorage()));

    final navigation = NavigationService();
    locator.registerSingleton<NavigationService>(navigation);

    final platform = await PlatformService.getInstance();
    locator.registerSingleton<PlatformService>(platform!);

    final db = await AppDatabase().getInstance();
    locator.registerSingleton<AppDatabase>(db!);

    locator.registerSingleton<ApiService>(
      ApiService(dio: Dio(
        BaseOptions(
            baseUrl: 'https://pandapan.bexmovil.com/api',
            persistentConnection: true,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(minutes: 3),
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
      ), storageService: locator<LocalStorageService>(), testing: false),
    );

    locator.registerSingleton<ApiRepository>(
      ApiRepositoryImpl(locator<ApiService>()),
    );

    locator.registerSingleton<DatabaseRepository>(
      DatabaseRepositoryImpl(locator<AppDatabase>()),
    );

    locator.registerSingleton<LocationRepository>(
      LocationRepository(),
    );
  }

}

Future<void> unregisterDependencies() async {
  final storage = await LocalStorageService.getInstance();
  locator.unregister<LocalStorageService>(instance: storage!);
}
