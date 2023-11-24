import 'package:bexmovil/src/presentation/widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';


class SyncView extends StatefulWidget {
  const SyncView({super.key});

  @override
  State<SyncView> createState() => _SyncViewState();
}

class _SyncViewState extends State<SyncView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sincronizado',
            style: TextStyle(
              fontSize: 22            
            ),
          ),
          Text('Mientras esperas, conoce nuestras ultimas novedades. '),

          SizedBox(height: 40,),

          //aca pondremos el widget personalizado

          CustomCard(
            text: 'Escanea el codigo y obten tu calendario para computador o tu fondo de pantalla para celular', 
            color: Colors.orange
          ),

          SizedBox(height: 20,),

          CustomCard(
            text: '¿Quieres ver el catalogo de agility gold? encuentralo aqui',
            color: Colors.green
            )
        ],
      );
    
  }
}