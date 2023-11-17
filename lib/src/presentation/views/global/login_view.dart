import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_elevated_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/services/navigation.dart';

import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final NavigationService _navigationService = locator<NavigationService>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

OriginLocation origin = OriginLocation(
  name: "Origin A",
  availableQuantity: 50,
  isSelected: true,
);

Product myProduct = Product(
  lastSoldOn: DateTime.now(),
  lastQuantitySold: 10,
  code: "ABC123",
  name: "Sample Product",
  sellingPrice: 25.0,
  discount: 50,
  availableUnits: 100,
  quantity: 20,
  originLocation: origin,
);

class _LoginViewState extends State<LoginView> {
  TextEditingController passwordController = TextEditingController();
  late RecoveryPasswordBloc recoveryBloc;

  @override
  void initState() {
    recoveryBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    super.initState();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void togglePasswordVisibility() {
      setState(() {
        obscureText = !obscureText;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
            'https://cdn.shopify.com/s/files/1/0579/4453/9318/files/Banner_Retal-01_480x480.png?v=1632324712',
            fit: BoxFit.contain,
            width: 200.0,
            height: 100.0),
        Padding(
          padding: const EdgeInsets.only(
              bottom: Const.space25, left: Const.space25, right: Const.space25),
          child: CustomTextFormField(
              controller: TextEditingController(),
              hintText: 'Usuario o correo'),
        ),
        Padding(
            padding: const EdgeInsets.only(
                left: Const.space25, right: Const.space25),
            child: CustomTextFormField(
              controller: passwordController,
              obscureText: obscureText,
              hintText: 'Contraseña',
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: theme.primaryColor, // Cambia el color del icono
                ),
                onPressed: togglePasswordVisibility,
              ),
            )),
        gapH12,
        Padding(
          padding: const EdgeInsets.all(Const.space25),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                shape: const LinearBorder(),
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            _navigationService.goTo(Routes.codeFormRequest);
                            recoveryBloc
                                .add(const StartRecovery(type: 'Email'));
                          },
                          title: Text(
                            'Email',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                          subtitle: Text(
                              'Obten tu código de verificación por correo electrónico.',
                              style: theme.textTheme.bodyMedium!),
                        ),
                        ListTile(
                          onTap: () {
                            _navigationService.goTo(Routes.codeFormRequest);
                            recoveryBloc.add(const StartRecovery(type: 'SMS'));
                          },
                          title: Text(
                            'SMS',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.primaryColor),
                          ),
                          subtitle: const Text(
                              'Obten tu código de verificación por mensaje de texto'),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Text(
              '¿Olvidaste tu contraseña?',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.primaryColor, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        gapH32,
        CustomElevatedButton(
          width: 150,
          height: 50,
          onTap: () {},
          child: Text(
            'Iniciar',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
