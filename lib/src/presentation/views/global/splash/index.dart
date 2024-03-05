import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

//bloc
import '../../../blocs/splash/splash_bloc.dart';

//widgets
import './features/body.dart';

//services
import '../../../../locator.dart';
import '../../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

// This the widget where the BLoC states and events are handled.
class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashScreenBloc, SplashScreenState>(
      listener: (context, state) {
        if (state is Loaded) {
          _navigationService.goTo(state.route!);
        }
      },
      child: UpgradeAlert(upgrader: Upgrader(
          debugDisplayAlways: false,
          debugLogging: true
      ), child: const SplashScreenWidget()),
    );
  }
}
