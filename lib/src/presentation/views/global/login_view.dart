import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

//cubit
import '../../cubits/login/login_cubit.dart';

//blocs
import '../../blocs/recovery_password/recovery_password_bloc.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/gaps.dart';
import '../../../utils/constants/screens.dart';

//widgets
import '../../widgets/global/custom_back_button.dart';
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/global/custom_textformfield.dart';
import '../../widgets/version_widget.dart';

part '../../widgets/global/form_login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;
  late RecoveryPasswordBloc recoveryBloc;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    recoveryBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    loginCubit = BlocProvider.of<LoginCubit>(context);

    rememberSession();
    super.initState();
  }

  void rememberSession() {
    var usernameStorage = loginCubit.storageService?.getString('username');
    var passwordStorage = loginCubit.storageService?.getString('password');

    if (usernameStorage != null) {
      setState(() {
        usernameController.text = usernameStorage;
      });
    }

    if (passwordStorage != null) {
      setState(() {
        passwordController.text = passwordStorage;
      });
    }
  }

  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  //TODO [Sebastian Monroy] add back button to company and onPress function call loginCubit goToCompany method (ya esta implementado)
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => buildBlocConsumer(size, theme),
    );
  }

  Widget buildBlocConsumer(Size size, ThemeData theme) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return _buildBody(size, theme, state);
      },
    );
  }

  void buildBlocListener(context, state) {
    if (state is LoginSuccess || state is LoginFailed) {
      if (state.error != null) {
        buildSnackBar(context, state.error!);
      } else {
        loginCubit.goToSync();
      }
    }
  }

  Widget _buildBody(Size size, ThemeData theme, LoginState state) {
    return SafeArea(
      key: const Key('LoginSuccess'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(Const.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  onTap: () {
                    loginCubit.goToCompany();
                  },
                ),
                const SizedBox()
              ],
            ),
          ),
          gapH64,
          gapH64,
          CachedNetworkImage(
            fit: BoxFit.contain,
            width: double.infinity,
            height: 100.0,
            imageUrl: state.enterprise != null && state.enterprise!.logo != null
                ? 'https://${state.enterprise!.name}.bexmovil.com/img/enterprise/${state.enterprise!.logo}'
                : '',
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          gapH64,
          Padding(
            padding: const EdgeInsets.only(
                bottom: Const.space25,
                left: Const.space25,
                right: Const.space25),
            child: CustomTextFormField(
                controller: usernameController, hintText: 'Usuario o correo'),
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
            ),
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.all(Const.space25),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: theme.cardColor,
                  shape: const LinearBorder(),
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: Screens.heigth(context) * 0.25,
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
                                    color: theme.primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              loginCubit.navigationService?.goTo(Routes.codeFormRequest);
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
                              loginCubit.navigationService?.goTo(Routes.codeFormRequest);
                              // recoveryBloc
                              //     .add(const StartRecovery(type: 'SMS'));
                            },
                            title: Text(
                              'SMS',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.primaryColor),
                            ),
                            subtitle: Text(
                              'Obten tu código de verificación por mensaje de texto',
                              style: theme.textTheme.bodyMedium!,
                            ),
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
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.primaryColor),
              ),
            ),
          ),
          gapH36,
          BlocSelector<LoginCubit, LoginState, bool>(
              selector: (state) => state is LoginLoading ? true : false,
              builder: (context, booleanState) => CustomElevatedButton(
                    width: 150,
                    height: 50,
                    onTap: () => booleanState
                        ? null
                        : loginCubit.differenceHours(
                            usernameController.text, passwordController.text),
                    child: booleanState
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            'Iniciar',
                            style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  )),
          gapH36,
          const Expanded(child: VersionWidget()),
        ],
      ),
    );
  }
}
