import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CodeVerificationView extends StatelessWidget {
  const CodeVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 56,
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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CustomBackButton(), SizedBox()],
          ),
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              'Verificación',
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            gapH16,
            const Text('Ingrese el código enviado al número'),
            gapH12,
            Text(
              '+57 3227399944',
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        )),
        Pinput(
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          errorTextStyle: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.error),
          validator: (s) {
            if (s == '2222') {
              _navigationService.goTo(Routes.recoverPassword);
              return null;
            } else {
              return 'Errorr';
            }
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) => print(pin),
        ),
        Expanded(
          child: Column(
            children: [
              gapH36,
              const Text('No recibió el código?'),
              gapH12,
              Text(
                'Reenviar',
                style: theme.textTheme.bodyMedium!
                    .copyWith(color: theme.primaryColor),
              ),
            ],
          ),
        ),
        Expanded(child: Container())
      ],
    ));
  }
}
