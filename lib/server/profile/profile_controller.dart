import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:middilook/pages/profile_pages/profile_page.dart';

class ProfileController extends GetxController {

  final Rx<Map<String, dynamic>> _userMap = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userMap => _userMap.value;

  final Rx<String?> _userID = "".obs;

  updateCurrentUserID(String visitUserID) {
    _userID.value = visitUserID;

    retrieveUserInformation();
  }


  retrieveUserInformation() async {
    //get user info
    DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(_userID.value)
        .get();

    final userInfo = userDocumentSnapshot.data() as dynamic;

    String userEmail = userInfo["email"];
    String userName = userInfo["name"];
    String userImage = userInfo["image"];
    String userUID = userInfo["uid"];

    int totalPurchaseLinkVisited = 0;

    List<String> thumbnailsList = [];

    List<String> videosList = [];
    List<int> videosVisitCountList=[];

    List<String> videoIDList = [];

    //get user's videos info
    var currentUserVideos = await FirebaseFirestore.instance
        .collection("videos")
        .orderBy("publishedDateTime", descending: true)
        .where("userID", isEqualTo: _userID.value)
        .get();

    for (int i = 0; i < currentUserVideos.docs.length; i++) {
      thumbnailsList
          .add((currentUserVideos.docs[i].data() as dynamic)["thumbnailUrl"]);
    
      totalPurchaseLinkVisited += (currentUserVideos.docs[i].data() as dynamic)["purchaseLinkCount"] as int;

      videosList
      .add((currentUserVideos.docs[i].data() as dynamic)["videoUrl"]);
      
      videosVisitCountList
      .add((currentUserVideos.docs[i].data() as dynamic)["purchaseLinkCount"] as int);

      videoIDList
      .add((currentUserVideos.docs[i].data() as dynamic)["videoID"] as String);
    }
    // print(totalPurchaseLinkVisited);


_userMap.value = {
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUID": userUID,
      "totalPurchaseLinkCount": totalPurchaseLinkVisited.toString(),
      "thumbnailsList": thumbnailsList,
      "videosList": videosList,
      "videosVisitCountList": videosVisitCountList,
      "videoIDList": videoIDList,
    };

    
    update();
  }

  //update user profile
  updateCurrentUserName(String userName) async {
    try {
      final Map<String, dynamic> userNameMap = {
        "name": userName,
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userID.value)
          .update(userNameMap);

      Get.offAll(MyProfile());

      Get.snackbar("User Name", "you username is update successfully.");
    } catch (errorMsg) {
      Get.snackbar("Error Updating Your Name", "Please try again.");
    }
  }

  updateCurrentUserProfilePhoto(File userImage) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("Profile Images")
          .child(FirebaseAuth.instance.currentUser!.uid);

      UploadTask uploadTask = reference.putFile(userImage);
      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadImageUrl = await taskSnapshot.ref.getDownloadURL();

      final Map<String, dynamic> userImageMap = {
        "image": downloadImageUrl,
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userID.value)
          .update(userImageMap);

      Get.offAll(MyProfile());

      Get.snackbar(
          "User Profile Photo", "you Profile photo is update successfully.");
    } catch (errorMsg) {
      Get.snackbar("Error Updating Profile Photo", "Please try again");
    }
  }

}
