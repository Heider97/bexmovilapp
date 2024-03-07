import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc
import '../../../blocs/network/network_bloc.dart';

//features
import '../../../widgets/atomsbox.dart';
import 'features/form_enterprise.dart';

//widgets
import 'widgets/carousel.dart';

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
    return const Center(
      child: AppIconText(
        path: 'assets/svg/offline.svg',
        messages: ['No tienes conexión a internet'],
      ),
    );
  }

  Widget _buildBodyNetworkSuccess(Size size) {
    return const Column(
      children: [CustomCarousel(), EnterpriseForm()],
    );
  }
}
