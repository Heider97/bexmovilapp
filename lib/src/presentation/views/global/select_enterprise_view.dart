import 'package:bexmovil/src/presentation/widgets/global/custom_carousel.dart';
import 'package:bexmovil/src/presentation/widgets/global/enterprise_form.dart';
import 'package:flutter/material.dart';

class SelectEnterpriceView extends StatelessWidget {
  const SelectEnterpriceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CustomCarousel(), EnterpriceForm()],
      ),
    );
  }
}



//TODO VALIDATE FORM...
