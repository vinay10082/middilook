import 'package:flutter/material.dart';

class MyRightButtons extends StatelessWidget {

  final icon;
  final String text;

  const MyRightButtons({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
    
    child: Column(children: [
      IconButton(
        onPressed: ()
        {
          
        }, 
        icon: icon,
        ),
      Text(text, style: TextStyle(color: Colors.white)),
    ]),);
  }
}
