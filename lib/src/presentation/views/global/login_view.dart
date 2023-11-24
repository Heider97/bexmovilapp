import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_back_button.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

//cubit

import '../../cubits/login/login_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/gaps.dart';

//widgets
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/global/custom_textformfield.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

part '../../widgets/global/form_login.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();
final NavigationService _navigationService = locator<NavigationService>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;
  // late RecoveryPasswordBloc recoveryBloc;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    // recoveryBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    loginCubit = BlocProvider.of<LoginCubit>(context);

    rememberSession();
    super.initState();
  }

  void rememberSession() {
    var usernameStorage = _storageService.getString('username');
    var passwordStorage = _storageService.getString('password');

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

  //TODO [Sebastian Monroy] add back button to company and onPress function call loginCubit goToCompany method
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
        loginCubit.goToHome();
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
            ),
          ),
          gapH16,
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
                              // recoveryBloc
                              //     .add(const StartRecovery(type: 'Email'));
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
                              // recoveryBloc
                              //     .add(const StartRecovery(type: 'SMS'));
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
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.primaryColor),
              ),
            ),
          ),
          gapH36,
          CustomElevatedButton(
            width: 150,
            height: 50,
            onTap: () => context
                .read<LoginCubit>()
                .differenceHours(usernameController.value, passwordController.value),
            child: Text(
              'Iniciar',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
