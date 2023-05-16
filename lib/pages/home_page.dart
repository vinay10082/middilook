import 'package:flutter/material.dart';
import 'package:middilook/pages/user_upload_pages/upload_page_1.dart';

import '../posts/post1.dart';
import '../posts/post2.dart';
import '../posts/post3.dart';
import '../utils/posthome_utils/bottom_button.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  //controlling the scrolling of pages
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
        controller: _controller,
        scrollDirection: Axis.vertical,
      children: [Post1(), Post2(), Post3()],
      ),
      Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(padding: EdgeInsets.only(bottom: 10.0),
            child: BottomButton(
              bottomicon: Icons.add_circle_outline_sharp,
              )
            )
        ),
        ]
      )
      
    
      
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //   BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //   BottomNavigationBarItem(icon: Icon(Icons.add_sharp), label: ''),
      //   BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      // ],)

    );
  }
}
