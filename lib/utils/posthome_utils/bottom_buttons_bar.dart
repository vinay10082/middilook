import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:middilook/global.dart';

import 'package:middilook/pages/authentication_page/login_page.dart';
import 'package:video_compress/video_compress.dart';

import '../../pages/profile_pages/profile_page.dart';
import '../../pages/user_upload_pages/upload_page_1.dart';

class MyBottomButtonBar extends StatefulWidget {
  const MyBottomButtonBar(
      {super.key, this.uploadicon, this.profileicon, this.searchicon});

  final uploadicon;
  final profileicon;
  final searchicon;

  @override
  State<MyBottomButtonBar> createState() => _MyBottomButtonBarState();
}

class _MyBottomButtonBarState extends State<MyBottomButtonBar> {
  late Rx<User?> _currentUser;

  //uploading video file from gallery
  void getVideoFile(ImageSource sourceImg) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);

    if (videoFile != null) {
      Get.snackbar(
        "Video is Processing",
        "Wait! This App is in beta testing mode, Don't use Copywrite song.",
        duration: Duration(seconds: 10),
      );

      final thumbnailImage =
          await VideoCompress.getFileThumbnail(videoFile.path);

      await VideoCompress.compressVideo(videoFile.path,
          quality: VideoQuality.LowQuality);

      Get.to(UploadPlayer(
          videoFile: File(videoFile.path),
          videoPath: videoFile.path,
          thumbnailImage: thumbnailImage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
//this is add video button
        IconButton(
          icon: widget.uploadicon,
          iconSize: 50,
          color: Colors.white,
          onPressed: () {
            setState(() {
              _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
              _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
            });
            ever(_currentUser, (User? currentUser) {
              if (currentUser == null) {
                Get.to(MyLoginAuth());
              } else {
                getVideoFile(ImageSource.gallery);
              }
            });
          },
        ),

// //this is search button
// IconButton(
//   onPressed: ()
//   {
//     //this is function to oper search page
//     // Get.to(MySearch());
//   },
//   icon: widget.searchicon,
//   iconSize: 30,
//   color: Colors.white,
//   ),

//this is profile button
        IconButton(
          onPressed: () {
            setState(() {
              _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
              _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
            });
            ever(_currentUser, (User? currentUser) {
              if (currentUser == null) {
                Get.to(MyLoginAuth());
              } else {
                Get.to(MyProfile());
              }
            });
          },
          icon: Icon(widget.profileicon),
          iconSize: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}
