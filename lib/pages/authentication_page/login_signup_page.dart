import 'package:flutter/material.dart';

class MyAuthentication extends StatefulWidget {
  const MyAuthentication({super.key});

  @override
  State<MyAuthentication> createState() => _MyAuthenticationState();
}

class _MyAuthenticationState extends State<MyAuthentication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('this is authentication page'),
      ) 
    );
  }
}