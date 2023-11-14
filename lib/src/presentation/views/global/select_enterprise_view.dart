import 'package:flutter/material.dart';

//widgets
import '../../widgets/global/custom_carousel.dart';
import '../../widgets/global/enterprise_form.dart';

class SelectEnterpriseView extends StatelessWidget {
  const SelectEnterpriseView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CustomCarousel(), EnterpriseForm()],
      ),
    );
  }
}

//TODO VALIDATE FORM...
