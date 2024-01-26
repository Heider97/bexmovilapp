import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StepperWidget extends StatefulWidget {
  int currentStep;
  List<StepData> steps;

  StepperWidget({super.key, required this.currentStep, required this.steps});
  @override
  StepperWidgetState createState() => StepperWidgetState();
}

class StepperWidgetState extends State<StepperWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Stack(alignment: Alignment.center, children: [
          Positioned(
            top: 28,
            child: CustomPaint(
              size: Size(
                  size.width * 0.6, 2), // Ajusta el tamaño de la línea punteada
              painter: DashedLinePainter(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            buildStep(0, widget.steps[0]),
            const SizedBox(),
            buildStep(1, widget.steps[1]),
            const SizedBox(),
            buildStep(2, widget.steps[2])
          ]),
        ]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget buildStep(int index, StepData step) {
    ThemeData theme = Theme.of(context);
    index == widget.currentStep
        ? widget.steps[widget.currentStep].color = theme.primaryColor
        : widget.steps[widget.currentStep].color = theme.cardColor;

    return Column(
      children: [
        InkResponse(
          radius: 15,
          onTap: () {
            if (index != widget.currentStep) {
              setState(() {
                widget.steps[widget.currentStep].color =
                    theme.cardColor; // Resetea el color del paso actual
                widget.currentStep = index; // Cambia el paso actual
                widget.steps[widget.currentStep].color = theme.primaryColor;
                // Establece el color del nuevo paso actual
              });
            }
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: index == widget.currentStep
                        ? Colors.black.withOpacity(0.4)
                        : Colors.white.withOpacity(0),
                    blurRadius: index == widget.currentStep ? 5 : 0,
                    offset: const Offset(0, 6) // Elevación más notoria
                    ),
              ],
              shape: BoxShape.circle,
              color:
                  index == widget.currentStep ? step.color : Colors.grey[200],
            ),
            child: Center(
              child: ClipOval(
                clipBehavior: Clip.none,
                child: Image.asset(
                  width: 20,
                  height: 20,
                  index == widget.currentStep
                      ? step.image
                      : step.onDisableImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),

        gapH12, // Espacio entre la imagen y el texto
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  void changeStep(int step, ThemeData theme) {
    for (StepData step in widget.steps) {
      step.color = theme.cardColor;
    }

    setState(() {
      widget.steps[widget.currentStep].color =
          theme.cardColor; // Resetea el color del paso actual
      widget.currentStep += step; // Cambia el paso actual
      widget.steps[widget.currentStep].color =
          theme.primaryColor; // Establece el color del nuevo paso actual
    });
  }
}

class StepData {
  String label;
  String image;
  String onDisableImage;
  Color color;

  StepData(this.label, this.image, this.color, this.onDisableImage);
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Color de la línea punteada
      ..strokeWidth = 1 // Grosor de la línea punteada
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 1; // Ancho de cada segmento punteado
    const double dashSpace = 5; // Espacio entre los segmentos punteados

    double currentX = 0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0),
        Offset(currentX + dashWidth, 0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
