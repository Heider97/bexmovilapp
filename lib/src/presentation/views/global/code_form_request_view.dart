//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/presentation/widgets/atoms/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc
import 'package:bexmovil/src/presentation/blocs/recovery_password/recovery_password_bloc.dart';
//domain
import 'package:bexmovil/src/domain/models/requests/recovery_code_request.dart';
import 'package:bexmovil/src/domain/repositories/api_repository.dart';
//utils
import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:bexmovil/src/utils/validators.dart';
//widgets
//services
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';

final NavigationService _navigationService = locator<NavigationService>();

class CodeFormRequestView extends StatefulWidget {
  const CodeFormRequestView({super.key});

  @override
  State<CodeFormRequestView> createState() => _CodeFormRequestViewState();
}

class _CodeFormRequestViewState extends State<CodeFormRequestView> {
  TextEditingController textController = TextEditingController();
  final GlobalKey<FormAutovalidateState> _formAutoValidateState =
      GlobalKey<FormAutovalidateState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  late RecoveryPasswordBloc recoveryPasswordBloc;

  bool isloading = false;

  @override
  void initState() {
    recoveryPasswordBloc = BlocProvider.of<RecoveryPasswordBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<RecoveryPasswordBloc, RecoveryPasswordState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              gapH12,
              const Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [AppBackButton(), SizedBox()],
                ),
              ),
              FormAutovalidate(
                keyForm: _formKey,
                key: _formAutoValidateState,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    gapH12,
                    SizedBox(
                      width: Screens.width(context) * 0.87,
                      child: Text(
                        'Te enviaremos un código para restablecer la contraseña.',
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.normal),
                      ),
                    ),
                    gapH20,
                    // SizedBox(
                    //   width: Screens.width(context) * 0.87,
                    //   child: CustomTextFormField(
                    //       focusNode: focusNode,
                    //       validator: (state.type == 'SMS')
                    //           ? Validator().number
                    //           : Validator().email,
                    //       controller: textController,
                    //       hintText: (state.type == 'SMS')
                    //           ? 'Ingrese el número de celular'
                    //           : 'Dirección de correo electrónico'),
                    // ),
                    gapH48,
                    // SizedBox(
                    //   width: Screens.width(context) * 0.87,
                    //   child: CustomElevatedButton(
                    //     enable: true,
                    //     isLoading: isloading,
                    //     onTap: () async {
                    //       if (_formAutoValidateState.currentState!
                    //           .validateForm()) {
                    //         setState(() {
                    //           isloading = true;
                    //         });
                    //         recoveryPasswordBloc.add(RequestCode(
                    //             context: context,
                    //             recoveryMethod: textController.text));
                    //
                    //         setState(() {
                    //           isloading = false;
                    //         });
                    //       }
                    //     },
                    //     borderRadius: Const.space12,
                    //     child: Text(
                    //       'Restablecer',
                    //       style: theme.textTheme.bodyMedium!.copyWith(
                    //           color: Colors.white, fontWeight: FontWeight.w500),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

bool isValidPhoneNumber(String input) {
  RegExp regex = RegExp(r'^[0-9]{9,}$');
  return regex.hasMatch(input);
}

bool isValidEmail(String input) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return regex.hasMatch(input);
}
