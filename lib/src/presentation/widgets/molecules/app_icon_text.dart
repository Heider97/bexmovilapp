import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconText extends StatelessWidget {
  final Key? keyWidget;
  final String path;
  final List<String> messages;

  const AppIconText(
      {super.key, required this.path, required this.messages, this.keyWidget});

  @override
  Widget build(BuildContext context) {
    return Center(
      key: keyWidget,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(path, height: 150, width: 180),
          for (var message in messages) Text(message)
        ],
      ),
    );
  }
}
