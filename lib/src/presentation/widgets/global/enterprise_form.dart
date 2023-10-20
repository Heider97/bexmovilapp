import 'package:bexmovil/src/presentation/widgets/global/custom_elevated_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_textformfield.dart';
import 'package:flutter/material.dart';

class EnterpriceForm extends StatelessWidget {
  const EnterpriceForm({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: size.height * 0.33,
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
                    controller: TextEditingController(),
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
                child: CustomElevatedButton(
                  onTap: () {},
                  child: Text(
                    'Siguiente',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
