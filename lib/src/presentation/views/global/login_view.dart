import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

//blocs
import '../../blocs/network/network_bloc.dart';

//cubit
import '../../cubits/login/login_cubit.dart';

//models
import '../../../domain/models/enterprise.dart';

//utils
import '../../../utils/constants/strings.dart';

//service
import '../../../locator.dart';
import '../../../services/navigation.dart';
import '../../../services/storage.dart';

//widgets
import '../../widgets/default_button_widget.dart';
part '../../widgets/form_login_widget.dart';

final NavigationService _navigationService = locator<NavigationService>();
final LocalStorageService _storageService = locator<LocalStorageService>();

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;

  Enterprise? enterprise;

  final formKey = GlobalKey<FormState>();

  TextEditingController username = TextEditingController(text: 'kminchelle');
  TextEditingController password = TextEditingController(text: '0lelplR');

  @override
  void initState() {
    rememberSession();
    super.initState();
  }

  void rememberSession() {
    var usernameStorage = _storageService.getString('username');
    var passwordStorage = _storageService.getString('password');

    if (usernameStorage != null) {
      setState(() {
        username.text = usernameStorage;
      });
    }

    if (passwordStorage != null) {
      setState(() {
        password.text = passwordStorage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    loginCubit = BlocProvider.of<LoginCubit>(context);

    return Scaffold(
      appBar: buildAppBar,
      extendBodyBehindAppBar: true,
      body: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (current, previous) => current != previous,
        builder: (context, state) => buildBlocConsumer(size),
      ),
    );
  }

  AppBar get buildAppBar => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => context.read<LoginCubit>().selectCompanyName(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      );

  Widget _buildBody(Size size, state) {
    return Stack(
      children: [
        Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/bg-login-1.jpg"),
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: BlocBuilder<NetworkBloc, NetworkState>(
                  builder: (context, networkState) {
                if (networkState is NetworkFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                            'assets/animations/1611-online-offline.json',
                            height: 180,
                            width: 180),
                        const Text('No tiene conexión o tu conexión es lenta.')
                      ],
                    ),
                  );
                } else if (networkState is NetworkSuccess) {
                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: size.height / 4,
                        width: size.width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.enterprise != null &&
                                              state.enterprise!.name != null
                                          ? state.enterprise!.name!
                                          : 'demo',
                                      maxLines: 2,
                                      style: TextStyle(
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 2.0,
                                              color: Colors.white,
                                            ),
                                            Shadow(
                                              offset: Offset(0.0, 0.0),
                                              blurRadius: 3.0,
                                              color: Colors.white,
                                            ),
                                          ],
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'bexmovil.com',
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // CircleAvatar(
                                //   radius: 50,
                                //   child: CachedNetworkImage(
                                //     width: double.infinity,
                                //     height: 100.0,
                                //     imageUrl: state.enterprise != null &&
                                //             state.enterprise!.logo != null
                                //         ? 'https://bexdeliveries.com/${state.enterprise!.logo}'
                                //         : '',
                                //     placeholder: (context, url) =>
                                //         const CircularProgressIndicator(),
                                //     errorWidget: (context, url, error) =>
                                //         const Icon(Icons.error),
                                //   ),
                                // )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      buildForm(context, state)
                    ],
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Algo ocurrió mientras cargaba la información'),
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: null,
                        )
                      ],
                    ),
                  );
                }
              }),
            )),
      ],
    );
  }

  Widget buildBlocConsumer(Size size) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return _buildBody(size, state);
      },
    );
  }

  void buildBlocListener(context, state) {
    if (state is LoginSuccess || state is LoginFailed) {
      if (state.error != null) {
        buildSnackBar(context, state.error!);
      } else {
        _navigationService.replaceTo(homeRoute);
      }
    }
  }

  Widget buildForm(BuildContext context, LoginState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            buildTextField(username, kNameNullError, 'Usuario'),
            const SizedBox(height: 10.0),
            buildTextField(password, kPassNullError, 'Contraseña'),
            const SizedBox(height: 120.0),
            buildButton(context, state),
          ],
        ),
      ),
    );
  }
}
