import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

//domain
import 'package:bexmovil/src/domain/models/kpi.dart';
//utils
import '../../../../../utils/constants/screens.dart';
//widgets
import 'card_kpi.dart';

class SlidableKpi extends StatefulWidget {
  final List<Kpi> kpis;

  const SlidableKpi({
    super.key,
    required this.kpis,
  });

  @override
  State<SlidableKpi> createState() => _SlidableKpiState();
}

class _SlidableKpiState extends State<SlidableKpi> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Screens.width(context) / 1.6,
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlayInterval:
            const Duration(
                seconds: 4),
            aspectRatio: 2,
            enlargeCenterPage: true,
            scrollDirection:
            Axis.vertical,
            autoPlay: true,
            viewportFraction: 1,
          ),
          items: widget.kpis.map((kpi) => CardKpi(kpi: kpi)).toList()
        ));
  }
}
