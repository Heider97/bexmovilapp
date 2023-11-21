//TODO [Heider Zapa] Organize
import 'package:bexmovil/src/utils/constants/screens.dart';
import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomPromotionCard extends StatelessWidget {
  final String cardText;
  final MaterialColor? color;
  final String? navigateTo;

  const CustomPromotionCard({
    super.key,
    required this.cardText,
    this.navigateTo,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.background1),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: 120,
        width: Screens.width(context) * 0.9,
        decoration: BoxDecoration(
            color: (color != null) ? color : theme.primaryColor,
            borderRadius: BorderRadius.circular(20)),
        child: (navigateTo != null)
            ? InkWell(
                onTap: () {
                  print('navigate To');
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Opacity(
                      opacity: 0.2,
                      child: Image.asset(Assets.background1, fit: BoxFit.cover),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(Const.padding),
                        child: Center(
                            child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cardText,
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    fontSize: 17,
                                    color: theme.cardColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              if (navigateTo != null)
                                const WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons
                                        .arrowUpRightFromSquare, // Reemplaza con el icono que desees
                                    size:
                                        16, // Ajusta el tamaño del icono según tus necesidades
                                    color: Colors
                                        .white, // Opcional: ajusta el color del icono
                                  ),
                                ),
                            ],
                          ),
                        )))
                  ],
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Image.asset(Assets.background1, fit: BoxFit.cover),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(Const.padding),
                      child: Center(
                          child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: cardText,
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  fontSize: 17,
                                  color: theme.cardColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            if (navigateTo != null)
                              const WidgetSpan(
                                child: Icon(
                                  FontAwesomeIcons
                                      .squareArrowUpRight, // Reemplaza con el icono que desees
                                  size:
                                      16, // Ajusta el tamaño del icono según tus necesidades
                                  color: Colors
                                      .white, // Opcional: ajusta el color del icono
                                ),
                              ),
                          ],
                        ),
                      )))
                ],
              ),
      ),
    );
  }
}
