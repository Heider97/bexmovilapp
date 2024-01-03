import 'package:bexmovil/src/utils/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final Axis axis;
  final String text;
  final Color color;
  final String? url;

  const CustomCard(
      {super.key,
      this.axis = Axis.vertical,
      required this.text,
      required this.color,
      this.url});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onLongPress: () => _launchUrl(url),
      child: Container(
        width: 330,
        height: axis == Axis.vertical ? 134 : 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: (color == Colors.green)
                ? Color(0XFF53E88B)
                : theme.primaryColor),
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
                    Text(
                      text,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: const Icon(
                            FontAwesomeIcons.arrowUpRightFromSquare,
                            size: 15,
                            color: Colors.white),
                        onPressed: () => _launchUrl(url)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
