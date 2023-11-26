import 'package:bexmovil/src/utils/regex.dart';
import 'package:flutter/material.dart';

class Validator {
  String? email(String? value) {
    Pattern pattern = RegExHelpers.email;
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(value!)) {
      return "Por favor, introduce una dirección de correo electrónico válida. \nsin espacios";
    } else {
      return null;
    }
  }

  String? passwordConfirm({String? value, String? confirm}) {
    Pattern pattern = r'^.{6,16}$';
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(value!)) {
      return "La contraseña debe tener un mínimo de 8 caracteres y máximo 16  y  debe contener:  al  menos un carácter  especial,  una  letra  mayúscula y un  dato numérico";
    } else if (value != confirm) {
      return "las contraseñas no coinciden";
    } else {
      return null;
    }
  }

  String? password(String? value) {
    Pattern pattern = r'^.{6,16}$';
    RegExp regex = RegExp(pattern.toString());

    if (!regex.hasMatch(value!)) {
      return "La contraseña debe tener un mínimo de 8 caracteres y máximo 16  y  debe contener:  al  menos un carácter  especial,  una  letra  mayúscula y un  dato numérico";
    } else {
      return null;
    }
  }

  String? name(String? value) {
    Pattern pattern = r'^.{6,50}$';
    // Pattern pattern = RegExHelpers.name;
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return "nombre invalido";
    } else {
      return null;
    }
  }

  String? number(String? value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value!)) {
      return "Por favor, introduzca un número.";
    } else {
      return null;
    }
  }

  String? notEmpty(String value, String error) {
    if (value.trim().isEmpty) {
      return error;
    } else {
      return null;
    }
  }
}

class FormAutovalidate extends StatefulWidget {
  final Widget child;
  final GlobalKey<FormState> keyForm;

  const FormAutovalidate({Key? key, required this.child, required this.keyForm})
      : super(key: key);

  @override
  FormAutovalidateState createState() => FormAutovalidateState();
}

class FormAutovalidateState extends State<FormAutovalidate> {
  late AutovalidateMode _autoValidate;

  @override
  void initState() {
    super.initState();
    _autoValidate = AutovalidateMode.disabled;
  }

  bool validateForm() {
    final isValidate = widget.keyForm.currentState?.validate();
    if (!isValidate!) setState(() => _autoValidate = AutovalidateMode.always);
    return isValidate;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.keyForm,
      autovalidateMode: _autoValidate,
      child: widget.child,
    );
  }
}
