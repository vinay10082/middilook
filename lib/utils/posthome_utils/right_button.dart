import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final icon;
  final String text;

  const MyButton({this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
    
    child: Column(children: [
      Icon(
        icon,
        size: 30,
        color: Colors.white
      ),
      SizedBox(
        height: 10,
      ),
      Text(text, style: TextStyle(color: Colors.white)),
    ]),);
  }
}
