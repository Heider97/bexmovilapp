import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../../cubits/initial/initial_cubit.dart';

//utils
import '../../../../../utils/validators.dart';

//widgets
import '../../../../widgets/atoms/app_text_form_field.dart';
import '../../../../widgets/version_widget.dart';

class EnterpriseForm extends StatefulWidget {
  const EnterpriseForm({super.key});

  @override
  State<EnterpriseForm> createState() => _EnterpriseFormState();
}

class _EnterpriseFormState extends State<EnterpriseForm> {
  final companyNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormAutovalidateState> _formAutoValidateState =
  GlobalKey<FormAutovalidateState>();

  late InitialCubit initialCubit;

  @override
  void initState() {
    initialCubit = BlocProvider.of<InitialCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<InitialCubit, InitialState>(
        builder: (context, state) => buildBlocConsumer(size, theme));
  }

  Widget buildBlocConsumer(Size size, ThemeData theme) {
    return BlocConsumer<InitialCubit, InitialState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return _buildBody(size, state, theme);
      },
    );
  }

  void buildBlocListener(context, state) {
    if (state is InitialSuccess || state is InitialFailed) {
      if (state.error == null) {
        initialCubit.goToLogin();
      }
    }
  }

  Widget _buildBody(Size size, InitialState state, ThemeData theme) {
    return FormAutovalidate(
      keyForm: _formKey,
      key: _formAutoValidateState,
      child: SizedBox(
        height: size.height * 0.52,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30),
                    child: Text(
                      'Seleccione la empresa',
                      style:
                      theme.textTheme.displayLarge!.copyWith(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 10.0, left: 22, right: 22),
                    child: AppTextFormField(
                      controller: companyNameController,
                      labelText: 'Nombre de la empresa',
                      // validator: Validator().name,
                    ),
                  )
                ],
              ),
            ),
            // Expanded(
            //   child: Center(
            //     child: SizedBox(
            //       width: 150,
            //       height: 50,
            //       child: BlocSelector<InitialCubit, InitialState, bool>(
            //           selector: (state) =>
            //           state is InitialLoading ? true : false,
            //           builder: (context, booleanState) => CustomElevatedButton(
            //             width: 150,
            //             height: 50,
            //             onTap: () {
            //               if (booleanState) {
            //                 null;
            //               } else {
            //                 if (_formAutoValidateState.currentState!
            //                     .validateForm()) {
            //                   initialCubit
            //                       .getEnterprise(companyNameController);
            //                 }
            //               }
            //             },
            //             child: booleanState
            //                 ? const CircularProgressIndicator(
            //               valueColor:
            //               AlwaysStoppedAnimation(Colors.white),
            //             )
            //                 : Text(
            //               'Siguiente',
            //               style: theme.textTheme.bodyLarge!.copyWith(
            //                   fontWeight: FontWeight.bold,
            //                   color: Colors.white),
            //             ),
            //           )),
            //     ),
            //   ),
            // ),
            const Expanded(child: VersionWidget())
          ],
        ),
      ),
    );
  }
}
