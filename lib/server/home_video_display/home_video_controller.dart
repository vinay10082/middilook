import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:middilook/server/upload_video/video.dart';

class ControllerHomeVideos extends GetxController {
  final Rx<List<Video>> homeVideosList = Rx<List<Video>>([]);

  List<Video> get homeAllVideosList => homeVideosList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    homeVideosList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .orderBy("purchaseLinkCount", descending: true)
        .snapshots()
        .map((QuerySnapshot snapshotQuery) {
      List<Video> videosList = [];

      for (var eachVideo in snapshotQuery.docs) {
        videosList.add(Video.fromDocumentSnapshot(eachVideo));
      }
      return videosList;
    }));
  }
}
