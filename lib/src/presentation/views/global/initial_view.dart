
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

//models
import '../../../domain/models/enterprise.dart';

//utils
import '../../../utils/constants/nums.dart';
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/colors.dart';

//cubits
import '../../cubits/initial/initial_cubit.dart';
import '../../cubits/network/network_cubit.dart';
import '../../cubits/network/network_state.dart';

//widgets
import '../../widgets/default_button_widget.dart';

//service
import '../../../locator.dart';
import '../../../services/navigation.dart';
import '../../../services/storage.dart';

final NavigationService _navigationService = locator<NavigationService>();
final LocalStorageService _storageService = locator<LocalStorageService>();

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  InitialViewState createState() => InitialViewState();
}

class InitialViewState extends State<InitialView> {
  late InitialCubit initialCubit;
  bool isLoading = false;
  bool showSuffix = true;
  final FocusNode _focus = FocusNode();
  final TextEditingController companyNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  void rememberSession() {
    if (_storageService.getString('token') != null) {
      _navigationService.goTo(homeRoute);
    }
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        showSuffix = false;
      });
    } else {
      showSuffix = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    initialCubit = BlocProvider.of<InitialCubit>(context);

    return Scaffold(
        body: BlocBuilder<InitialCubit, InitialState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        rememberSession();
        if (state.runtimeType == InitialLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state.runtimeType == InitialSuccess ||
            state.runtimeType == InitialFailed) {
          return _buildBody(size, state.enterprise, state.error);
        } else {
          return const SizedBox();
        }
      },
    ));
  }

  Widget _buildBody(Size size, Enterprise? enterprise, String? error) {
    return SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/bg-initial-1.jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.darken),
                fit: BoxFit.cover,
              ),
            ),
            child: BlocBuilder<NetworkCubit, NetworkState>(
                builder: (context, networkState) {
              switch (networkState.runtimeType) {
                case NetworkInitial:
                  return const Center(child: CupertinoActivityIndicator());
                case NetworkFailure:
                  return _buildNetworkFailed();
                case NetworkSuccess:
                  return _buildBodyNetworkSuccess(size, error);
                default:
                  return const SizedBox();
              }
            })));
  }

  Widget _buildNetworkFailed() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/1611-online-offline.json',
              height: 180, width: 180),
          const Text('No tiene conexión o tu conexión es lenta.')
        ],
      ),
    );
  }

  Widget _buildBodyNetworkSuccess(Size size, String? error) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bienvenido a',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.bold)),
                  Text('Bexmovil',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          shadows: [
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
                          ])),
                  Text('La mejor app para tomar pedidos.',
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ],
              )),
          const SizedBox(height: 20),
          Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding),
                  child: buildCompanyField()),
              if (error != null)
                Padding(
                    padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        bottom: kDefaultPadding),
                    child: Text(error,
                        style: const TextStyle(color: Colors.white))),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(
                    left: kDefaultPadding, right: kDefaultPadding),
                child: DefaultButton(
                    widget: isLoading
                        ? const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text('Comenzar'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.normal)),
                    press: () async {
                      initialCubit.getEnterprise(companyNameController);
                    }),
              ),
            ],
          ),
        ]);
  }

  MediaQuery buildCompanyField() {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 0.80 * MediaQuery.textScaleFactorOf(context),
      ),
      child: TextField(
        controller: companyNameController,
        focusNode: _focus,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          hintText: 'empresa',
          hintStyle: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          border: OutlineInputBorder(gapPadding: 1),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
