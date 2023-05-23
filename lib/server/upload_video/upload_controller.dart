import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:video_compress/video_compress.dart';

import 'video.dart';

//uploading video controller
class UploadController extends GetxController{

  compressVideoFile(String videoFilePath) async
  {
    final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

    return compressedVideoFilePath!.file;
  }

  uploadCompressedVideoFiletoFirebaseStorage(String videoID, String videoFilePath) async
  {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
    .child("All Videos")
    .child(videoID)
    .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlofUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlofUploadedVideo;
  }

  getThumbnailImage(String videoFilePath) async
  {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImage;
  }

  uploadThumbnailImagetoFirebaseStorage(String videoID, String videoFilePath) async
  {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
    .child("All Thumbnails")
    .child(videoID)
    .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlofUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlofUploadedThumbnail;
  }

  saveVideoInformationToFirestoreDatabase(String description, String purchaseLink, String videoFilePath, BuildContext context) async
  {
    try 
    {
      String videoID = DateTime.now().millisecondsSinceEpoch.toString();

      //1. upload video to storage
      String videodownloadUrl = await uploadCompressedVideoFiletoFirebaseStorage(videoID, videoFilePath);

      //2. upload thumbnail to storage
      String thumbnaildownloadUrl = await uploadThumbnailImagetoFirebaseStorage(videoID, videoFilePath);

      //3. save overall video info to firestore database
      Video videoObject = Video(
        videoID: videoID,
        description: description,
        purchaseLink: purchaseLink,
        purchaseLinkCount: 0,
        videoUrl: videodownloadUrl,
        thumbnailUrl: thumbnaildownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance.collection("videos").doc(videoID).set(videoObject.toJson());

      //
      //here the code of progress bar
      //
      Get.to(const MyHome());

      Get.snackbar("New Video", "we have successfully uploaded your video");
    } 
    catch (errorMsg) 
    {
      Get.snackbar("video Upload Unseccessfull", "Error occured, your video is not uploaded. Try Again.");

    }
  }
}
