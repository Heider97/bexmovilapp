import 'package:bexmovil/src/domain/models/porduct.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_elevated_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';

import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//utils
import '../../../utils/constants/strings.dart';

//widgets
import '../../cubits/login/login_cubit.dart';
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/global/custom_textformfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

OriginLocation origin = OriginLocation(
  name: "Origin A",
  availableQuantity: 50,
  isSelected: true,
);

Product myProduct = Product(
  lastSoldOn: DateTime.now(),
  lastQuantitySold: 10,
  code: "ABC123",
  name: "Sample Product",
  sellingPrice: 25.0,
  discount: 50,
  availableUnits: 100,
  quantity: 20,
  originLocation: origin,
);

class _LoginViewState extends State<LoginView> {
  String hora = 'cargando...';

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String tdata = DateFormat("HH:mm:ss").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    obtenerHoraDesdeWeb();
  }

//funcion de la hora desde la web
  Future<void> obtenerHoraDesdeWeb() async {
    try {
      final response =
          await http.get(Uri.parse('https://worldtimeapi.org/api/ip'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        String nuevaHora = data['datetime'];

        var date = DateFormat("HH:mm:ss").format(DateTime.parse(nuevaHora).toLocal());

        setState(() {
          hora = date;
        });
      } else {
        throw Exception('no se pudo obtener la hora desde la web');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        hora = 'Error al obtener la hora';
      });
    }
  }

  bool esHoraIgual() {
    return hora == obtenerHoraActual();
  }

  String obtenerHoraActual() {
    return DateTime.now().toIso8601String();
  }

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void togglePasswordVisibility() {
      setState(() {
        obscureText = !obscureText;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
            'https://cdn.shopify.com/s/files/1/0579/4453/9318/files/Banner_Retal-01_480x480.png?v=1632324712',
            fit: BoxFit.contain,
            width: 200.0,
            height: 100.0),
        Padding(
          padding: const EdgeInsets.only(
              bottom: Const.space25, left: Const.space25, right: Const.space25),
          child: CustomTextFormField(
              controller: TextEditingController(),
              hintText: 'Usuario o correo'),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: Const.space25, right: Const.space25),
          child: CustomTextFormField(
            controller: passwordController,
            obscureText: obscureText,
            hintText: 'Contraseña',
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: theme.primaryColor, // Cambia el color del icono
              ),
              onPressed: togglePasswordVisibility,
            ),
          ),
        ),
        Text(tdata),
        Text(hora),
        CustomElevatedButton(
          width: 150,
          height: 50,
          onTap: () {
            if (tdata == hora) {
              context
                  .read<LoginCubit>()
                  .onPressedLogin(usernameController, passwordController);
            } else {
              print(
                  'error: las horas no son iguales, no se puede iniciar sesion');
            }
          },
          child: Text(
            'Iniciar',
            style: theme.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
