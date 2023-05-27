import 'dart:io';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:middilook/pages/user_upload_pages/upload_page_2.dart';

class UserUpload extends StatefulWidget {
  const UserUpload({super.key});

  @override
  State<UserUpload> createState() => _UserUploadState();
}

class _UserUploadState extends State<UserUpload> {


  void getVideoFile(ImageSource sourceImg) async {

  final videoFile = await ImagePicker().pickVideo(source: sourceImg);
      

    if(videoFile != null){
      Get.to(UploadPlayer(videoFile: File(videoFile.path), videoPath: videoFile.path));
      }
  }
          //   onPressed: () {
          //   getVideoFile(ImageSource.camera);
          //   },
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 200.0, 0, 0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(Icons.cloud_upload_outlined, size: 200.0, color: Colors.blue,),
                Text('Upload Maximum 30 Seconds Video', style: TextStyle(fontSize: 20.0),)
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: IconButton(
              onPressed: () {
                getVideoFile(ImageSource.camera);
              },
              icon: Icon(Icons.video_camera_back_outlined),
              iconSize: 60.0,
              ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
              onPressed: () {
                getVideoFile(ImageSource.gallery);
              },
              icon: Icon(Icons.file_upload_sharp),
              iconSize: 60.0,
              ),
          )
        ],
      )
    );
  }
}
