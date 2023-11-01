import 'package:flutter/material.dart';

class CustomIconBack extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomIconBack({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new, size: 15, color: Colors.black),
                SizedBox(width: 5),
                Text('Regresar',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600))
              ],
            )),
      ),
    );
  }
}
