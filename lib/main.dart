import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_repository/location_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:upgrader/upgrader.dart';

//theme
import 'app_localizations.dart';
import 'src/config/theme/index.dart';

//domain
import 'src/domain/repositories/api_repository.dart';
import 'src/domain/repositories/database_repository.dart';

//cubits
import 'src/presentation/cubits/initial/initial_cubit.dart';
import 'src/presentation/cubits/permission/permission_cubit.dart';
import 'src/presentation/cubits/politics/politics_cubit.dart';

import 'src/presentation/cubits/login/login_cubit.dart';
import 'src/presentation/cubits/home/home_cubit.dart';
import 'src/presentation/cubits/category/category_cubit.dart';
import 'src/presentation/cubits/product/product_cubit.dart';
import 'src/presentation/cubits/productivity/productivity_cubit.dart';
import 'src/presentation/cubits/schedule/schedule_cubit.dart';

//blocs
import 'src/presentation/blocs/location/location_bloc.dart';
import 'src/presentation/blocs/network/network_bloc.dart';
import 'src/presentation/blocs/processing_queue/processing_queue_bloc.dart';
import 'src/presentation/blocs/splash/splash_bloc.dart';

//utils
import 'src/utils/constants/strings.dart';
import 'src/utils/bloc/bloc_observer.dart';

//service
import 'src/locator.dart';
import 'src/services/navigation.dart';

//router
import 'src/config/router/index.dart' as router;

//undefined
import 'src/presentation/views/global/undefined_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Only call clearSavedSettings() during testing to reset internal values.
  await Upgrader.clearSavedSettings(); // REMOVE this for release builds

  // On Android, the default behavior will be to use the Google Play Store
  // version of the app.
  // On iOS, the default behavior will be to use the App Store version of
  // the app, so update the Bundle Identifier in example/ios/Runner with a
  // valid identifier already in the App Store.
  await initializeDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale locale;

  void setLocale(Locale value) {
    setState(() {
      locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BLOC PROVIDERS
        BlocProvider(create: (_) => SplashScreenBloc()),
        BlocProvider(
          create: (_) => NetworkBloc()..add(NetworkObserve()),
        ),
        BlocProvider(
          create: (context) => ProcessingQueueCubit(
              locator<DatabaseRepository>(),
              BlocProvider.of<NetworkBloc>(context))
            ..add(ProcessingQueueObserve()),
        ),
        BlocProvider(
            create: (context) => InitialCubit(locator<ApiRepository>())),
        BlocProvider(create: (context) => PermissionCubit()),
        BlocProvider(create: (context) => PoliticsCubit()),
        BlocProvider(
            create: (context) => LoginCubit(
                  locator<ApiRepository>(),
                  locator<DatabaseRepository>(),
                )),
        BlocProvider(
            create: (context) => HomeCubit(
                  locator<DatabaseRepository>(),
                )),
        BlocProvider(
            create: (context) => CategoryCubit(
                  locator<DatabaseRepository>(),
                )),
        BlocProvider(
            create: (context) => ProductCubit(
                  locator<DatabaseRepository>(),
                )),
        BlocProvider(
            create: (context) => ProductivityCubit(
                  locator<DatabaseRepository>(),
                )),
        BlocProvider(
            create: (context) => ScheduleCubit(
                  locator<DatabaseRepository>(),
                )),

        //REPOSITORY PROVIDER.

        RepositoryProvider(
            create: (_) => LocationRepository(),
            child: BlocProvider(
              create: (context) => LocationBloc(
                  locationRepository: context.read<LocationRepository>())
                ..add(GetLocation()),
            )),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: appTitle,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalization.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
              builder: (BuildContext context) => UndefinedView(
                    name: settings.name,
                  )),
          initialRoute: '/splash',
          onGenerateRoute: router.generateRoute,
        ),
      ),
    );
  }
}
