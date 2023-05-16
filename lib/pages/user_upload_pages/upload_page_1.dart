import 'package:flutter/material.dart';
import '../../utils/upload__utils/close_button.dart';

class UserUpload extends StatefulWidget {
  const UserUpload({super.key});

  @override
  State<UserUpload> createState() => _UserUploadState();
}

class _UserUploadState extends State<UserUpload> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Padding(padding: EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.topRight,
              child:CrossButton(),
            )
            ),
        ]
        
      ),
    );
  }
}