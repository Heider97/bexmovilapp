import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../../cubits/initial/initial_cubit.dart';

//utils
import '../../../../../utils/validators.dart';

//widgets
import '../../../../widgets/atomsbox.dart';

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
    return SizedBox(
        height: size.height * 0.52,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.sm),
          child: FormAutovalidate(
            keyForm: _formKey,
            key: _formAutoValidateState,
            child: AppForm(
              title: AppText('Seleccione la empresa'),
              formItems: [
                Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 22, right: 22),
                    child: AppTextFormField.outlined(
                      labelText: 'Empresa',
                      controller: companyNameController,
                    )),
              ],
              formItemNames: const ['Empresa'],
              formButton: AppElevatedButton(
                minimumSize: Size(size.width, 50),
                child: BlocSelector<InitialCubit, InitialState, bool>(
                    selector: (state) => state is InitialLoading ? true : false,
                    builder: (context, condition) {
                      if (condition) {
                        return const CupertinoActivityIndicator();
                      } else {
                        return AppText('Siguiente');
                      }
                    }),
                onPressed: () {
                  if (_formAutoValidateState.currentState!.validateForm()) {
                    initialCubit.getEnterprise(companyNameController);
                  }
                },
              ),
            ),
          ),
        ));
  }
}
