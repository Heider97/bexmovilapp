import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import '../../../../blocs/splash/splash_bloc.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({Key? key}) : super(key: key);

  @override
  SplashScreenWidgetState createState() => SplashScreenWidgetState();
}

class SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    _dispatchEvent(context);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset('assets/icons/BEX.png',
                      fit: BoxFit.cover, width: 200.0, height: 300.0),
                  Text('Solución en ventas integral',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  //This method will dispatch the navigateToHomeScreen event.
  void _dispatchEvent(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(HandleNavigateScreenEvent());
  }
}
