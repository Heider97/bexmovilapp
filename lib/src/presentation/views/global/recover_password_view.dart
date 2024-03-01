//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/atoms/app_back_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({super.key});

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  final GlobalKey<FormAutovalidateState> _formAutoValidateState =
      GlobalKey<FormAutovalidateState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obscureText = true;
  bool obscureTextPaswordConfirm = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerVerification =
      TextEditingController();

  late RecoveryPasswordBloc recoveryPasswordBloc;

  @override
  void initState() {
    recoveryPasswordBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FormAutovalidate(
            keyForm: _formKey,
            key: _formAutoValidateState,
            child: Padding(
              padding: const EdgeInsets.all(Const.space25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapH12,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [AppBackButton(), SizedBox()],
                  ),
                  gapH12,
                  Text('Recupere su\nContraseña',
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 30)),
                  gapH12,
                  const Text('Ingrese su nueva contraseña'),
                  gapH32,
                  // CustomTextFormField(
                  //     controller: passwordController,
                  //     obscureText: obscureText,
                  //     validator: Validator().password,
                  //     hintText: 'Nueva contraseña',
                  //     suffixIcon: IconButton(
                  //       onPressed: togglePasswordVisibility,
                  //       icon: Icon(
                  //         obscureText ? Icons.visibility : Icons.visibility_off,
                  //         color:
                  //             theme.primaryColor, // Cambia el color del icono
                  //       ),
                  //     )),
                  // gapH24,
                  // CustomTextFormField(
                  //     controller: passwordControllerVerification,
                  //     obscureText: obscureTextPaswordConfirm,
                  //     hintText: 'Verifique su nueva contraseña',
                  //     validator: (value) => Validator().passwordConfirm(
                  //         value: passwordController.text, confirm: value),
                  //     suffixIcon: IconButton(
                  //       onPressed: togglePasswordConfirmVisibility,
                  //       icon: Icon(
                  //         obscureTextPaswordConfirm
                  //             ? Icons.visibility
                  //             : Icons.visibility_off,
                  //         color:
                  //             theme.primaryColor, // Cambia el color del icono
                  //       ),
                  //     )),
                  gapH36,
                  // Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: CustomElevatedButton(
                  //       onTap: () {
                  //         if (_formAutoValidateState.currentState!
                  //             .validateForm()) {
                  //           recoveryPasswordBloc.add(ChangePassword(
                  //               password: passwordController.text,
                  //               confirmPassword:
                  //                   passwordControllerVerification.text,
                  //               context: context));
                  //         }
                  //       },
                  //       child: Text(
                  //         'Siguiente',
                  //         style: theme.textTheme.bodyMedium!.copyWith(
                  //             color: Colors.white, fontWeight: FontWeight.bold),
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void togglePasswordConfirmVisibility() {
    setState(() {
      obscureTextPaswordConfirm = !obscureTextPaswordConfirm;
    });
  }
}
