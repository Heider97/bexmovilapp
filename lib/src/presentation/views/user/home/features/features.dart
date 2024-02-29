import 'package:flutter/material.dart';
//domain
import '../../../../../domain/models/feature.dart';
//widgets
import '../../../../widgets/custom_card_widget.dart';

class HomeFeatures extends StatelessWidget {
  final List<Feature>? features;

  const HomeFeatures({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: features != null ? features!.length : 0,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CustomCard(
                axis: Axis.horizontal,
                text: features![index].descripcion!,
                url: features![index].urldesc,
                color: index / 2 == 0 ? Colors.orange : Colors.green),
          ),
        ));
  }
}
