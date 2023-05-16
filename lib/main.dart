import 'package:flutter/material.dart';
import 'package:middilook/pages/home_page.dart';
// import 'package:middilook/pages/upload_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageController()
    );
  }
}

class PageController extends StatefulWidget {
  const PageController({super.key});

  @override
  State<PageController> createState() => _PageControllerState();
}

class _PageControllerState extends State<PageController> {

  // final List<Widget> pages = [
  //   MyHome(),
  //   UserUpload(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHome(),
    );
  }
}

