part of '../views/global/login_view.dart';

extension SnackBarWidget on LoginViewState {
  ScaffoldFeatureController buildSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }
}

extension TextFieldWidget on LoginViewState {
  Widget buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        labelStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Enter a value';
    } else {
      return null;
    }
  }
}

extension LoginButton on LoginViewState {
  Widget buildButton(BuildContext context, LoginState state) {
    return DefaultButton(
        widget: buildChild(state), press: () => buildOnPressed(context));
  }

  Future<void> buildOnPressed(BuildContext context) async {
    // if (formKey.currentState!.validate()) {
    //   context.read<LoginCubit>().onPressedLogin(username, password);
    // }

    context.read<LoginCubit>().onPressedLogin(username, password);
  }

  Widget buildChild(LoginState state) {
    return state is LoginLoading
        ? const CircularProgressIndicator.adaptive()
        : const Text('Iniciar',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white));
  }
}
