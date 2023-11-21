<<<<<<< Updated upstream
import 'package:bexmovil/src/presentation/cubits/login/login_cubit.dart';
=======
//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/services/navigation.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../utils/constants/strings.dart';

//widgets
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/global/custom_textformfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
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

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/icons/BEX.png',
              fit: BoxFit.cover,
              width: 250.0,
              height: 300.0,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                'https://cdn.shopify.com/s/files/1/0579/4453/9318/files/Banner_Retal-01_480x480.png?v=1632324712',
                fit: BoxFit.contain,
                width: 200.0,
                height: 100.0),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: Const.space25,
                  left: Const.space25,
                  right: Const.space25),
              child: CustomTextFormField(
                  controller: usernameController,
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
            Padding(
              padding: const EdgeInsets.all(Const.space25),
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.w600),
              ),
            ),
            CustomElevatedButton(
              width: 150,
              height: 50,
              onTap: () => context.read<LoginCubit>().onPressedLogin(usernameController, passwordController),
              child: Text(
                'Iniciar',
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          ],
        )
      ],
    );
  }
}
