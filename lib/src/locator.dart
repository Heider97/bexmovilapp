import 'package:get_it/get_it.dart';
import 'package:location_repository/location_repository.dart';
import 'package:sqflite/sqflite.dart';

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

Future<void> initializeDependencies() async {
  final storage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(storage!);

  locator.registerSingleton<CacheManager>(CacheManager(CacheStorage()));

  final navigation = NavigationService();
  locator.registerSingleton<NavigationService>(navigation);

  final platform = await PlatformService.getInstance();
  locator.registerSingleton<PlatformService>(platform!);

  final db = DatabaseHelper();
  locator.registerSingleton<DatabaseHelper>(db);

  locator.registerSingleton<ApiService>(
    ApiService(),
  );

  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<DatabaseHelper>()),
  );

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ApiService>()),
  );

  locator.registerSingleton<LocationRepository>(
    LocationRepository(),
  );
}
