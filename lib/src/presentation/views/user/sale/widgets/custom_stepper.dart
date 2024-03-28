import 'package:bexmovil/src/domain/models/client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_client.dart';
import 'package:bexmovil/src/presentation/views/user/sale/widgets/card_router_sale.dart';
import 'package:flutter/material.dart';

class StepperExample extends StatefulWidget {
  final List<Client> clients;
  const StepperExample({super.key, required this.clients});

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
      // controller: widget.controller,
      currentStep: _index,
      margin: EdgeInsets.zero,
      controlsBuilder: (context, controller) => Row(children: []),
      /* onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index < steps.length - 1) {
          setState(() {
            _index += 1;
          });
        }
      },
     */
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
