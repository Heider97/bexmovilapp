import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_router_sale.dart';
import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  final List<Client> clients;
/*   final ScrollController scrollController; */
  const StepperExample({
    super.key,
    required this.clients,
    /*  required this.scrollController */
  });

  @override
  StepperExampleState createState() => StepperExampleState();
}

class StepperExampleState extends State<StepperExample> {
  List<StepData> steps = [];

  @override
  void initState() {
    for (var client in widget.clients) {
      steps.add(StepData(client: client));
    }
    super.initState();
  }

  int _index = 0;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      // controller: widget.scrollController,
      currentStep: _index,
      margin: EdgeInsets.zero,
      controlsBuilder: (context, controller) => Row(children: []),
      onStepTapped: (int index) {
        setState(() {
          _index = index;
          isActive = true;
        });
      },
      steps: List.generate(steps.length, (index) {
        return Step(
          isActive: _index == index,
          title: Text(steps[index].client.businessName ??
              steps[index].client.name ??
              'No disponible'),
          content: CardClient(
            client: steps[index].client,
          ),
        );
      }),
    );
  }
}

class StepData {
  final Client client;

  StepData({required this.client});
}
