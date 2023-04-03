import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_repository/location_repository.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//theme
import 'src/config/theme/index.dart';

//domain
import 'src/domain/repositories/api_repository.dart';
import 'src/domain/repositories/database_repository.dart';

//cubits
import 'src/presentation/cubits/theme/theme_bloc.dart';
import 'src/presentation/cubits/initial/initial_cubit.dart';
import 'src/presentation/cubits/permission/permission_cubit.dart';
import 'src/presentation/cubits/politics/politics_cubit.dart';
import 'src/presentation/cubits/location/location_bloc.dart';
import 'src/presentation/cubits/login/login_cubit.dart';
import 'src/presentation/cubits/network/network_cubit.dart';
import 'src/presentation/cubits/network/network_event.dart';
import 'src/presentation/cubits/processing_queue/procesing_queue_bloc.dart';
import 'src/presentation/cubits/processing_queue/processing_queue_event.dart';
import 'src/presentation/cubits/home/home_cubit.dart';
import 'src/presentation/cubits/category/category_cubit.dart';

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

  await initializeDependencies();

  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => NetworkCubit()..add(NetworkObserve()),
          ),
          BlocProvider(
            create: (context) => ProcessingQueueCubit(
                locator<DatabaseRepository>(),
                BlocProvider.of<NetworkCubit>(context))
              ..add(ProcessingQueueObserve()),
          ),
          RepositoryProvider(
              create: (context) => LocationRepository(),
              child: BlocProvider(
                create: (context) => LocationBloc(
                    locationRepository: context.read<LocationRepository>())
                  ..add(GetLocation()),
              )),
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
        ],
        child: BlocProvider(
            create: (context) => ThemeBloc(),
            child:
                BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: OKToast(
                  child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: appTitle,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('en'), // English
                      Locale('es'), // Spanish
                    ],
                    theme: state.isDarkTheme ? AppTheme.light : AppTheme.dark,
                    darkTheme: AppTheme.dark,
                    themeMode: ThemeMode
                        .system, //this should be enoguh for most updated devices
                    navigatorKey: locator<NavigationService>().navigatorKey,
                    onUnknownRoute: (RouteSettings settings) =>
                        MaterialPageRoute(
                            builder: (BuildContext context) => UndefinedView(
                                  name: settings.name,
                                )),
                    initialRoute: '/splash',
                    onGenerateRoute: router.generateRoute,
                  ),
                ),
              );
            })));
  }
}
