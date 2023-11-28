import 'package:flutter/material.dart';
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
    return GestureDetector(
      onLongPress: () =>_launchUrl(url),
      child: Container(
        width: 330,
        height: axis == Axis.vertical ? 134 : 70,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(16), color: color),
        child: Stack(
          children: [
            const Image(
                color: Colors.black38,
                image: AssetImage(
                  'assets/images/bg-prom-card.png',
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
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
                          icon: const Icon(Icons.link, color: Colors.white),
                          onPressed: () =>_launchUrl(url)),
                    ],
                  ),
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
