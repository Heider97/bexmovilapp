//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/presentation/widgets/version_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//cubit
import '../../../presentation/cubits/initial/initial_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';

//widgets
import 'custom_elevated_button.dart';
import 'custom_textformfield.dart';

class EnterpriseForm extends StatefulWidget {
  const EnterpriseForm({super.key});

  @override
  State<EnterpriseForm> createState() => _EnterpriseFormState();
}

class _EnterpriseFormState extends State<EnterpriseForm> {
  final companyNameController = TextEditingController();
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
                    style: theme.textTheme.displayLarge!.copyWith(fontSize: 15),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 22, right: 22),
                  child: CustomTextFormField(
                    controller: companyNameController,
                    hintText: 'Nombre de la empresa',
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 150,
                height: 50,
                child: BlocSelector<InitialCubit, InitialState, bool>(
                    selector: (state) => state is InitialLoading ? true : false,
                    builder: (context, booleanState) => CustomElevatedButton(
                          width: 150,
                          height: 50,
                          onTap: () => booleanState
                              ? null
                              : initialCubit
                                  .getEnterprise(companyNameController),
                          child: booleanState
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : Text(
                                  'Siguiente',
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                        )),
              ),
            ),
          ),
          if (state.error != null)
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 22, right: 22),
                  child: Text(state.error!, textAlign: TextAlign.center)),
            ),
          const Expanded(child: VersionWidget())
        ],
      ),
    );
  }
}
