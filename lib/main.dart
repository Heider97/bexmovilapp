import 'dart:io';

import 'package:bexmovil/src/services/styled_dialog_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_repository/location_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

//theme
import 'app_localizations.dart';
// import 'src/config/theme/index.dart';

//domain
import 'src/domain/repositories/api_repository.dart';
import 'src/domain/repositories/database_repository.dart';

//providers
import 'src/presentation/providers/theme_provider.dart';

//cubits
import 'src/presentation/cubits/initial/initial_cubit.dart';
import 'src/presentation/cubits/permission/permission_cubit.dart';
import 'src/presentation/cubits/politics/politics_cubit.dart';

import 'src/presentation/cubits/login/login_cubit.dart';
import 'src/presentation/cubits/productivity/productivity_cubit.dart';
import 'src/presentation/cubits/schedule/schedule_cubit.dart';
import 'src/presentation/cubits/home/home_cubit.dart';
import 'src/presentation/cubits/navigation/navigation_cubit.dart';

//blocs
import 'src/presentation/blocs/location/location_bloc.dart';
import 'src/presentation/blocs/gps/gps_bloc.dart';
import 'src/presentation/blocs/network/network_bloc.dart';
import 'src/presentation/blocs/processing_queue/processing_queue_bloc.dart';
import 'src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'src/presentation/blocs/splash/splash_bloc.dart';
import 'src/presentation/blocs/sync_features/sync_features_bloc.dart';
import 'src/presentation/blocs/google_account/google_account_bloc.dart';
import 'src/presentation/blocs/sale/sale_bloc.dart';
import 'src/presentation/blocs/sale_stepper/sale_stepper_bloc.dart';
import 'src/presentation/blocs/search/search_bloc.dart';
import 'src/presentation/blocs/wallet/wallet_bloc.dart';

//utils
import 'src/utils/constants/strings.dart';
import 'src/utils/bloc/bloc_observer.dart';

//service
import 'src/locator.dart';
import 'src/services/storage.dart';
import 'src/services/navigation.dart';

//router
import 'src/config/router/routes.dart';

//widgets
import 'src/presentation/widgets/atomsbox.dart';

//undefined
import 'src/presentation/views/global/undefined_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then;

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
  void initState() {
    locator<StyledDialogController>()
        .registerDialogOf(style: Status.error, builder: showErrorGpsDialog);
    super.initState();
  }

  Future<void> showErrorGpsDialog() {
    final ctx = locator<NavigationService>().navigatorKey.currentState!.context;

    if (Platform.isAndroid) {
      return showDialog(
          barrierDismissible: false,
          context: ctx,
          builder: (_) {
            ThemeData theme = Theme.of(ctx);
            return PopScope(
              canPop: false,
              child: Dialog(
                backgroundColor: theme.scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        AppText('Activa la ubicación', fontSize: 26),
                        const SizedBox(
                          height: 20,
                        ),
                        SvgPicture.asset('assets/icons/pin.svg',
                            height: 100, width: 100),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                              "Necesitamos saber tu ubicacion,\n activa tu GPS para continuar disfrutando de la APP.",
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Geolocator.openLocationSettings();
                          },
                          child: Container(
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: AppText('Activar',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
            );
          });
    } else {
      return showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.error,
                      color: Colors.red.shade900,
                      size: 40,
                    ),
                  ),
                  const Text("Oh no!\n something went wrong."),
                ],
              ),
              content: Column(
                children: [
                  const Text(
                    textAlign: TextAlign.center,
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    'Necesitamos saber tu ubicacion,\n activa tu GPS para continuar disfrutando de la APP.',
                    style: TextStyle(
                      color: Colors.red.shade900,
                    ),
                  ),
                ],
              )));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BLOC PROVIDERS
        BlocProvider(
          create: (_) => NetworkBloc()..add(NetworkObserve()),
        ),
        BlocProvider(
            create: (_) => GpsBloc(
                navigationService: locator<NavigationService>(),
                storageService: locator<LocalStorageService>(),
                databaseRepository: locator<DatabaseRepository>())),
        BlocProvider(
          create: (context) => ProcessingQueueBloc(
              locator<DatabaseRepository>(),
              locator<ApiRepository>(),
              BlocProvider.of<NetworkBloc>(context))
            ..add(ProcessingQueueObserve()),
        ),
        BlocProvider(
            create: (_) => RecoveryPasswordBloc(locator<ApiRepository>())),
        BlocProvider(create: (_) => SplashScreenBloc()),
        BlocProvider(create: (_) => SearchBloc(locator<DatabaseRepository>())),
        BlocProvider(create: (_) => SaleStepperBloc()),
        BlocProvider(
            create: (_) => WalletBloc(locator<DatabaseRepository>(),
                locator<LocalStorageService>(), locator<NavigationService>())),
        BlocProvider(
            create: (_) => SaleBloc(
                locator<DatabaseRepository>(), locator<LocalStorageService>())
              ..add(LoadRouters())),
        BlocProvider(
          create: (context) => NavigationCubit(
              locator<DatabaseRepository>(),
              locator<NavigationService>(),
              BlocProvider.of<GpsBloc>(context)),
        ),
        BlocProvider(
            create: (context) => InitialCubit(locator<ApiRepository>())),
        BlocProvider(create: (context) => PermissionCubit()),
        BlocProvider(create: (context) => PoliticsCubit()),
        BlocProvider(
            create: (context) => LoginCubit(
                  locator<ApiRepository>(),
                  locator<DatabaseRepository>(),
                  locator<LocalStorageService>(),
                  locator<NavigationService>(),
                  locator<LocationRepository>(),
                )),
        BlocProvider(
            create: (context) => SyncFeaturesBloc(
                  locator<DatabaseRepository>(),
                  locator<ApiRepository>(),
                  BlocProvider.of<ProcessingQueueBloc>(context),
                  locator<NavigationService>(),
                  locator<LocalStorageService>(),
                )),
        BlocProvider(create: (context) => GoogleAccountBloc()),
        BlocProvider(
            create: (context) => HomeCubit(
                locator<DatabaseRepository>(),
                locator<ApiRepository>(),
                locator<LocalStorageService>(),
                locator<NavigationService>())),
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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, snapshot) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppConstants.appName,
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
                theme: AppTheme.theme,
                darkTheme: AppTheme.darkTheme,
                // themeMode: currentMode,
                navigatorKey: locator<NavigationService>().navigatorKey,
                onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
                    builder: (BuildContext context) => UndefinedView(
                          name: settings.name,
                        )),
                initialRoute: AppRoutes.splash,
                onGenerateRoute: Routes.onGenerateRoutes,
              ),
            );
          },
        ),
      ),
      //  ),
    );
  }
}
