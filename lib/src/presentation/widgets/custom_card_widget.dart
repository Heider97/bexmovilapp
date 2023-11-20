import 'package:flutter/material.dart';


class CustomCard extends StatelessWidget {

  final String text;
  final Color color;

  const CustomCard({
    super.key, 
    required this.text, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 134,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color
      ),
      child: Stack(
        children: [
          Image(
            color: Colors.black38,
            image: AssetImage('assets/images/bg-prom-card.png',)
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  text, 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}