import 'package:flutter/material.dart';

import '../pages/home_page.dart';

class CrossButton extends StatelessWidget {
  const CrossButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
              icon: Icon(Icons.close),
              iconSize: 50, 
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHome()));
               },
          
        ),
    );
  }
}