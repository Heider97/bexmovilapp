//TODO [Heider Zapa] Organize
import 'dart:async';

import 'package:bexmovil/src/presentation/widgets/atoms/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
//blocs
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
//domain
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
//utils
import 'package:bexmovil/src/utils/constants/gaps.dart';

//widgets

//services
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();
final ApiRepository _apiRepository = locator<ApiRepository>();

class CodeVerificationView extends StatefulWidget {
  const CodeVerificationView({super.key});

  @override
  State<CodeVerificationView> createState() => _CodeVerificationViewState();
}

class _CodeVerificationViewState extends State<CodeVerificationView> {
  late RecoveryPasswordBloc recoveryPasswordBloc;
  late Timer timer;
  TextEditingController pinPutController = TextEditingController();
  int _counter = 30;

  @override
  void initState() {
    recoveryPasswordBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    _startTimer();

    super.initState();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_counter == 0) {
          // Temporizador completado, realiza la lógica que necesites
          timer.cancel();
        } else {
          // Actualiza el estado para reflejar el nuevo valor del contador
          setState(() {
            _counter--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 46,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20, color: theme.primaryColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(245, 221, 192, 1),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: theme.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(252, 248, 243, 1),
      ),
    );

    return SafeArea(
        child: BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [AppBackButton(), SizedBox()],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  'Verificación',
                  style: theme.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: theme.primaryColor),
                ),
                gapH16,
                (state.type == 'SMS')
                    ? const Text('Ingrese el código enviado al número')
                    : const Text('Ingrese el código enviado al correo'),
                gapH12,
                (state.type == 'SMS')
                    ? Text(
                        '+57 ${state.phone}',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    : Text(
                        '${state.email}',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
              ],
            )),
            Column(
              children: [
                Pinput(
                  controller: pinPutController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorTextStyle: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.error),
                  validator: (pin) {
                    recoveryPasswordBloc
                        .add(ValidateCode(code: pin!, context: context));
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {},
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  gapH36,
                  const Text('No recibió el código?'),
                  gapH12,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: (_counter != 0) ? 0.5 : 1,
                        child: GestureDetector(
                          onTap: () {
                            if (_counter == 0) {
                              pinPutController.text = "";
                              setState(() {
                                _counter = 30;
                              });
                              _startTimer();
                              recoveryPasswordBloc.add(RetryCode(
                                  recoveryMethod: (state.type == 'SMS')
                                      ? state.phone!
                                      : state.email!));
                            }
                          },
                          child: Text(
                            'Reenviar',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                        ),
                      ),
                      (_counter != 0)
                          ? Text(
                              ' (Espera $_counter segundos) ',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            )
                          : Container()
                    ],
                  ),
                ],
              ),
            ),
            Expanded(child: Container())
          ],
        );
      },
    ));
  }
}
