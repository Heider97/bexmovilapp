import 'package:flutter/material.dart';

//utils
import '../../../utils/constants/nums.dart';
import '../../../utils/constants/gaps.dart';

//cubit
import '../../cubits/politics/politics_cubit.dart';

//widgets
import '../../widgets/atomsbox.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  LanguageViewState createState() => LanguageViewState();
}

class LanguageViewState extends State<LanguageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
      ),
    ));
  }
}
