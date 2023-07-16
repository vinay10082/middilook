import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:middilook/pages/authentication_page/phone_auth_page.dart';
import 'package:middilook/pages/search_pages/search_page.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:video_compress/video_compress.dart';
import 'package:middilook/global.dart';

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
        duration: const Duration(seconds: 20),
      );

      final thumbnailImage =
          await VideoCompress.getFileThumbnail(
            videoFile.path,
            );

     final compressedVideoFile = await VideoCompress.compressVideo(
        videoFile.path,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
        );

      

      Get.to(UploadPlayer(
          videoFile: compressedVideoFile!.file,
          videoPath: videoFile.path,
          thumbnailImage: thumbnailImage));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //this is search button
            IconButton(
              onPressed: () {
                Get.to(const MySearch());
              },
              icon: Showcase(
                key: key2, 
                description: 'Explore more videos',
                targetShapeBorder: const CircleBorder(),
                descriptionPadding: const EdgeInsets.all(8.0),
                targetPadding: const EdgeInsets.all(10),
                child: widget.searchicon,
              ),
              iconSize: 30,
              color: Colors.white,
            ),
            
//this is add video button
            IconButton(
              icon: Showcase(
                key: key1, 
                description: 'Upload video and get rewards',
                targetShapeBorder: const CircleBorder(),
                descriptionPadding: const EdgeInsets.all(8.0),
                targetPadding: const EdgeInsets.all(10),
                child: widget.uploadicon
                ),
              iconSize: 55,
              color: Colors.white,
              onPressed: () {
                setState(() {
                  _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
                  _currentUser
                      .bindStream(FirebaseAuth.instance.authStateChanges());
                });
                ever(_currentUser, (User? currentUser) {
                  if (currentUser == null) {
                    // Get.to(MyLoginAuth());
                    Get.to(const MyPhoneAuth());
                  } else {
                    getVideoFile(ImageSource.gallery);
                  }
                });
              },
            ),

//this is profile button
            IconButton(
              onPressed: () {
                setState(() {
                  _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
                  _currentUser
                      .bindStream(FirebaseAuth.instance.authStateChanges());
                });
                ever(_currentUser, (User? currentUser) {
                  if (currentUser == null) {
                    Get.to(const MyPhoneAuth());
                  } else {
                    Get.to(const MyProfile());
                  }
                });
              },
              icon: Showcase(
                key: key3, 
                description: 'View your profile',
                targetShapeBorder: const CircleBorder(),
                descriptionPadding: const EdgeInsets.all(8.0),
                targetPadding: const EdgeInsets.all(10),
                child: Icon(widget.profileicon),
              ),
              iconSize: 25,
              color: Colors.white,
            ),
          ],
        ));
  }
}
