import 'package:flutter/material.dart';


class CustomAlertDialog extends StatelessWidget {

  final String title;
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  final String textbutton;

  const CustomAlertDialog({
    super.key, 
    required this.title, 
    required this.icon, 
    required this.text, 
    required this.onPressed, 
    required this.textbutton
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=> showDialog(
        context: context, 
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: SizedBox(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Icon(icon.icon, color: Colors.orange,),
                const SizedBox(height: 10,),
                Text(text),
                const SizedBox(height: 10,),
                SizedBox(
                  width: 300,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      
                    ),
                    onPressed: onPressed, 
                    child: Text(textbutton, style: const TextStyle(color: Colors.white),)
                  ),
                )     
              ],
            ),
          ),
          elevation: 10,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        )
      ), child: const Text('Custom Alert Dialog'),
    );
  }
}