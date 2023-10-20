import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({super.key});

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final CarouselController _controller = CarouselController();
  final List<Widget> imageSliders = [
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/select-enterprice1.jpg',
          fit: BoxFit.fill,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/select-enterprice2.jpg',
          fit: BoxFit.fill,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/select-enterprice3.jpg',
            fit: BoxFit.fill)),
  ].toList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CarouselSlider(
      items: imageSliders,
      carouselController: _controller,
      options: CarouselOptions(
        height: double.maxFinite,
        scrollPhysics: const BouncingScrollPhysics(),
        viewportFraction: 1,
        autoPlay: false,
        //   enlargeCenterPage: true,
        /*  onPageChanged: (index, reason) {
         
          } */
      ),
    ));
  }
}
