import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:middilook/pages/user_upload_pages/upload_page_1.dart';
import 'package:video_compress/video_compress.dart';

import '../../global.dart';
import 'video.dart';

//uploading video controller
class UploadController extends GetxController {
  // compressVideoFile(String videoFilePath) async
  // {
  //   final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

  //   return compressedVideoFilePath!.file;
  // }

  uploadCompressedVideoFiletoFirebaseStorage(
      String videoID, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Videos")
        .child(videoID)
        // .putFile(await compressVideoFile(videoFilePath));
        .putFile(File(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlofUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlofUploadedVideo;
  }

  // getThumbnailImage(String videoFilePath) async
  // {
  //   final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

  //   return thumbnailImage;
  // }

  uploadThumbnailImagetoFirebaseStorage(
      String videoID, File thumbnailImage) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance
        .ref()
        .child("All Thumbnails")
        .child(videoID)
        .putFile(thumbnailImage);

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlofUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlofUploadedThumbnail;
  }

  saveVideoInformationToFirestoreDatabase(
      String description,
      String purchaseLink,
      String videoFilePath,
      File thumbnailImage,
      BuildContext context) async {
    try {
      DocumentSnapshot userDoumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      String videoID = DateTime.now().millisecondsSinceEpoch.toString();

      //1. upload video to storage
      String videodownloadUrl =
          await uploadCompressedVideoFiletoFirebaseStorage(
              videoID, videoFilePath);

      //2. upload thumbnail to storage
      String thumbnaildownloadUrl =
          await uploadThumbnailImagetoFirebaseStorage(videoID, thumbnailImage);

      //3. save overall video info to firestore database
      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDoumentSnapshot.data() as Map<String, dynamic>)["name"],
        videoID: videoID,
        description: description,
        purchaseLink: purchaseLink,
        purchaseLinkCount: 0,
        videoUrl: videodownloadUrl,
        thumbnailUrl: thumbnaildownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoID)
          .set(videoObject.toJson());

      //
      //here the code of progress bar
      //
      Get.offAll(MyHome());

      //off the progress indicator bar
      showProgressBar = false;

      Get.snackbar("New Video", "we have successfully uploaded your video");
    } catch (errorMsg) {
      //off the progress indicator bar
      showProgressBar = false;

      Get.offAll(MyHome());

      Get.snackbar("video Upload Unseccessfull",
          "Error occured, your video is not uploaded. Try Again.");
    }
  }
}
