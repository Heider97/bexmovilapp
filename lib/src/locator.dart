import 'package:get_it/get_it.dart';

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
import 'services/analytics.dart';
import 'services/storage.dart';
import 'services/navigation.dart';
import 'services/platform.dart';
import 'services/styled_dialog_controller.dart';
import 'services/query_loader.dart';
import 'services/logger.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerLazySingleton(() => FirebaseAnalyticsService());

  final storage = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(storage!);

  locator.registerSingleton<CacheManager>(CacheManager(CacheStorage()));

  final navigation = NavigationService();
  locator.registerSingleton<NavigationService>(navigation);

  final platform = await PlatformService.getInstance();
  locator.registerSingleton<PlatformService>(platform!);

  locator.registerSingleton<ApiService>(
    ApiService(storageService: locator<LocalStorageService>()),
  );

  final styledDialogController = StyledDialogController<Status>();
  locator.registerSingleton<StyledDialogController>(styledDialogController);

  final logger = LoggerService();
  locator.registerSingleton<LoggerService>(logger);

  final db = AppDatabase.instance;
  locator.registerSingleton<AppDatabase>(db);

  locator.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(locator<ApiService>()),
  );

  locator.registerSingleton<DatabaseRepository>(
    DatabaseRepositoryImpl(locator<AppDatabase>()),
  );

  final queryLoader = await QueryLoaderService.getInstance();
  locator.registerSingleton<QueryLoaderService>(queryLoader!);
}

Future<void> unregisterDependencies() async {
  final storage = await LocalStorageService.getInstance();
  locator.unregister<LocalStorageService>(instance: storage!);
}
