import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/screens.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

List<Widget> imageSliders = [];

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initScreens(context);
    return Expanded(
        child: CarouselSlider(
      items: imageSliders,
      carouselController: _controller,
      options: CarouselOptions(
        height: double.maxFinite,
        scrollPhysics: const BouncingScrollPhysics(),
        viewportFraction: 1,
        autoPlay: false,
      ),
    ));
  }
}

void initScreens(BuildContext context) {
  ThemeData theme = Theme.of(context);

  imageSliders = [
    CarouselCustomItem(
        theme: theme,
        image: 'assets/images/select-enterprice1.jpg',
        text:
            'Impulse sus ventas. Gestione clientes, asesores comerciales, pedidos, productos e inventario.',
        activePosition: 1),
    CarouselCustomItem(
        theme: theme,
        image: 'assets/images/select-enterprice2.jpg',
        text:
            'Todo lo que sus asesores, vendedores o telemercaderistas requieren para gestionar sus ventas.',
        activePosition: 2),
    CarouselCustomItem(
        theme: theme,
        image: 'assets/images/select-enterprice3.jpg',
        text:
            ' App para la fuerza de ventas de su compañía. Incluye herramientas de mercadeo, recaudos y PQRS.',
        activePosition: 3)
  ].toList();
}

class CarouselCustomItem extends StatelessWidget {
  const CarouselCustomItem(
      {super.key,
      required this.theme,
      required this.image,
      required this.activePosition,
      required this.text});

  final ThemeData theme;
  final String image;
  final int activePosition;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Const.radius),
          child: Image.asset(
            image,
            fit: BoxFit.fill, // Ajusta la propiedad fit según tus necesidades
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: Const.space25),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(Const.radius)),
              width: Screens.width(context) * 0.85,
              height: Screens.heigth(context) * 0.13,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(Const.padding),
                child: Column(
                  children: [
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: (activePosition == 1)
                                      ? theme.cardColor
                                      : theme.disabledColor,
                                  borderRadius:
                                      BorderRadius.circular(Const.radius)),
                              width: Screens.width(context) * 0.15,
                              height: Screens.heigth(context) * 0.005,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: Const.space12, right: Const.space12),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: (activePosition == 2)
                                        ? theme.cardColor
                                        : theme.disabledColor,
                                    borderRadius:
                                        BorderRadius.circular(Const.radius)),
                                width: Screens.width(context) * 0.15,
                                height: Screens.heigth(context) * 0.005,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: (activePosition == 3)
                                      ? theme.cardColor
                                      : theme.disabledColor,
                                  borderRadius:
                                      BorderRadius.circular(Const.radius)),
                              width: Screens.width(context) * 0.15,
                              height: Screens.heigth(context) * 0.005,
                            )
                          ]),
                    )
                  ],
                ),
              )),
            ),
          ),
        )
      ],
    );
  }
}
