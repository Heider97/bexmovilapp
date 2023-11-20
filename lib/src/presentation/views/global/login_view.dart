import 'package:bexmovil/src/presentation/cubits/home/home_cubit.dart';
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

//cubit
import '../../blocs/network/network_bloc.dart';
import '../../cubits/login/login_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/gaps.dart';
import '../../../utils/constants/strings.dart';

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

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late RecoveryPasswordBloc recoveryBloc;

  @override
  void initState() {
    recoveryBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
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
    loginCubit = BlocProvider.of<LoginCubit>(context);

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          fit: BoxFit.contain,
          width: double.infinity,
          height: 100.0,
          imageUrl: state.enterprise != null && state.enterprise!.logo != null
              ? 'https://${state.enterprise!.name}.bexmovil.com/img/enterprise/${state.enterprise!.logo}'
              : '',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        gapH16,
        Padding(
          padding: const EdgeInsets.only(
              bottom: Const.space25, left: Const.space25, right: Const.space25),
          child: CustomTextFormField(
              controller: TextEditingController(),
              hintText: 'Usuario o correo'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: Const.space25, right: Const.space25),
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
        CustomElevatedButton(
          width: 150,
          height: 50,
          onTap: () => context
              .read<LoginCubit>()
              .onPressedLogin(usernameController, passwordController),
          child: Text(
            'Iniciar',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
