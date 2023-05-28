import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:middilook/server/authentication/authentication_controller.dart';
// import 'package:middilook/pages/upload_page.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value)
  {
    Get.put(AuthenticationController());
  });

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(),
      ),
      home: PageController(),
    );
  }
}

class PageController extends StatefulWidget {
  const PageController({super.key});

  @override
  State<PageController> createState() => _PageControllerState();
}

class _PageControllerState extends State<PageController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHome(),
    );
  }
}

