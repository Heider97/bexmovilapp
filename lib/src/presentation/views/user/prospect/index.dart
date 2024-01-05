
import 'package:bexmovil/src/presentation/widgets/global/custom_check_button.dart';
import 'package:bexmovil/src/presentation/widgets/global/custom_close_cutton.dart';
import 'package:flutter/material.dart';


class ProspectSheduleView extends StatelessWidget {
  const ProspectSheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCloseButton(),
                    CustomCheckButton()
                  ],
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
              ),
              Text(
                'Nombre del cliente',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Cargo u ocupacion del cliente'
              ),
              
            ],
          )
        ],
      ),
    );
  }
}