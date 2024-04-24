import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
//utils
import '../../../utils/constants/strings.dart';
//widgets
import '../atoms/app_card.dart';
import '../atoms/app_text.dart';
import '../atoms/app_icon_button.dart';

class AppCardFeature extends StatelessWidget {
  final Axis axis;
  final String text;
  final Color color;
  final String? url;
  final double? height;

  const AppCardFeature(
      {super.key,
      this.axis = Axis.vertical,
      required this.text,
      required this.color,
      this.url,
      this.height});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return AppCard.filled(
      color: (color == Colors.green)
          ? const Color(0XFF53E88B)
          : theme.colorScheme.primary,
      onTap: () => _launchUrl(url),
      width: 200,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Opacity(
              opacity: (color == Colors.green) ? 1 : 0.5,
              child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    (color == Colors.green)
                        ? Assets.bgPromCardOrange
                        : Assets.bgPromCardGreen,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: AppText(text,
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
               
                    child: Icon(FontAwesomeIcons.arrowUpRightFromSquare,size: 20,),
                  )


              /*     AppIconButton(
                      child: const Icon(FontAwesomeIcons.arrowUpRightFromSquare,
                          size: 15, color: Colors.white),
                      onPressed: () => _launchUrl(url)), */
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
