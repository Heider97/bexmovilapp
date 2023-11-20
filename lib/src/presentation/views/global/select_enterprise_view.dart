import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

//bloc
import '../../blocs/network/network_bloc.dart';

//widgets
import '../../widgets/global/custom_carousel.dart';
import '../../widgets/global/enterprise_form.dart';

class SelectEnterpriseView extends StatefulWidget {
  const SelectEnterpriseView({super.key});

  @override
  State<SelectEnterpriseView> createState() => _SelectEnterpriseViewState();
}

class _SelectEnterpriseViewState extends State<SelectEnterpriseView> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: BlocBuilder<NetworkBloc, NetworkState>(
                    builder: (context, networkState) {
                  switch (networkState.runtimeType) {
                    case NetworkInitial:
                      return const Center(child: CupertinoActivityIndicator());
                    case NetworkFailure:
                      return _buildNetworkFailed();
                    case NetworkSuccess:
                      return _buildBodyNetworkSuccess(size);
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

  //TODO [Jairo Grande] fix ui carousel giving a mid size screen and do the keyboard don´t resize the screen
  Widget _buildBodyNetworkSuccess(Size size) {
    return const Column(
      children: [CustomCarousel(), EnterpriseForm()],
    );
  }
}
