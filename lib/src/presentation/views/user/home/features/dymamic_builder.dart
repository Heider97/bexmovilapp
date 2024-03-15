import 'package:flutter/cupertino.dart';
//domain
import '../../../../../domain/models/section.dart';

//utils
import '../../../../../utils/constants/gaps.dart';
//widgets
import '../../../../widgets/atoms/app_text.dart';

class DynamicBuilder extends StatelessWidget {

  final Section section;

  const DynamicBuilder({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH20,
        AppText(section.name!, fontSize: 20, fontWeight: FontWeight.bold),
        // ...section.components != null ? section.components!.map((e) {
        //   if(e.type == "kpi") {
        //   } else if (e.type == "list") {
        //
        //   } else if (e.type == "graphic") {
        //
        //   }
        // }) : []
      ],
    );
  }

}