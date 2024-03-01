import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//utils
import '../../../utils/constants/strings.dart';
//cubit
import '../../cubits/permission/permission_cubit.dart';

//widgets
import '../../widgets/atoms/app_text.dart';
import '../../widgets/custom_button_widget.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.green,
                  size: MediaQuery.of(context).size.height * 0.2,
                ),
                AppText(state.permissionRepository.displayTitle ??
                    "Permiso necesario"),
                AppText(
                  state.permissionRepository.displayMessage ??
                      "Para brindarle la mejor experiencia de usuario, necesitamos algunos permisos. Por favor permítelo.",
                ),
                CustomMaterialButton(
                    buttonText:
                        state.permissionRepository.buttonText ?? "Permitir",
                    onButtonPressed: () async {
                      if (state.permissionRepository.isGranted != null &&
                          state.permissionRepository.isGranted == true) {
                        _navigationService.goTo(AppRoutes.selectEnterprise);
                      } else {
                        return await permissionCubit.onRequestAllPermission();
                      }
                    }),
              ],
            );
          }),
        ),
      ),
    );
  }
}
