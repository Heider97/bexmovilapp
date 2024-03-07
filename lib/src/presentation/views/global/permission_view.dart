import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../utils/constants/gaps.dart';
import '../../../utils/constants/strings.dart';
//cubit
import '../../cubits/permission/permission_cubit.dart';

//widgets
import '../../widgets/atomsbox.dart';

//service
import '../../../locator.dart';
import '../../../services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class RequestPermissionView extends StatefulWidget {
  const RequestPermissionView({Key? key}) : super(key: key);

  @override
  RequestPermissionViewState createState() => RequestPermissionViewState();
}

class RequestPermissionViewState extends State<RequestPermissionView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: BlocConsumer<PermissionCubit, PermissionState>(
                listener: (context, state) {
              if (state is AllPermissionsGranted) {
                _navigationService.replaceTo(AppRoutes.selectEnterprise);
              }
            }, listenWhen: (previous, current) {
              return (current is AllPermissionsGranted);
            }, builder: (context, state) {
              var permissionCubit = context.watch<PermissionCubit>();
              permissionCubit.checkIfPermissionNeeded();
              if (state is AllPermissionsGranted ||
                  state is WaitingForPermission) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppIconText(
                      path: 'assets/icons/permission.svg', messages: []),
                  Wrap(
                    children: [
                      AppText(
                          state.permissionRepository.displayTitle ??
                              'Permiso necesario',
                          textAlign: TextAlign.justify,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                      gapH12,
                      AppText(
                          state.permissionRepository.displayMessage ??
                              'Para brindarle la mejor experiencia de usuario, necesitamos algunos permisos. Por favor permítelo.',
                          textAlign: TextAlign.justify,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ],
                  ),
                  AppElevatedButton(
                    minimumSize: const Size(70, 70),
                    child: AppText(
                        state.permissionRepository.buttonText ?? 'Permitir'),
                    onPressed: () async {
                      if (state.permissionRepository.isGranted != null &&
                          state.permissionRepository.isGranted == true) {
                        _navigationService.goTo(AppRoutes.selectEnterprise);
                      } else {
                        return await permissionCubit.onRequestAllPermission();
                      }
                    },
                  ),
                  gapH20
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
