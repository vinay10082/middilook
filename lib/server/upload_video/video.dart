//video modals
import 'package:cloud_firestore/cloud_firestore.dart';

class Video
{
  String? userID;
  String? userName;
  String? videoID;
  int? totalComments;
  List? likesList;
  String? artistSongName;
  String? description;
  String? purchaseLink;
  int? purchaseLinkCount;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userID,
    this.userName,
    this.videoID,
    this.totalComments,
    this.likesList,
    this.artistSongName,
    this.description,
    this.purchaseLink,
    this.purchaseLinkCount,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
  });

  Map<String, dynamic> toJson()=>
  {
    "userID": userID,
    "userName": userName,
    "videoID": videoID,
    "totalComments": totalComments,
    "likesList": likesList,
    "artistSongName": artistSongName,
    "description": description,
    "purchaseLink": purchaseLink,
    "purchaseLinkCount": purchaseLinkCount,
    "videoUrl": videoUrl,
    "thumbnailUrl": thumbnailUrl,
    "publishedDateTime": publishedDateTime,
  };

  static Video fromDocumentSnapshot(DocumentSnapshot snapshot)
  {
    var docSnapshot = snapshot.data() as Map<String, dynamic>;

    return Video(
      userID: docSnapshot["userID"],
      userName: docSnapshot["userName"],
      videoID: docSnapshot["videoID"],
      totalComments: docSnapshot["totalComments"],
      likesList: docSnapshot["likesList"],
      artistSongName: docSnapshot["artistSongName"],
      description: docSnapshot["description"],
      purchaseLink: docSnapshot["purchaseLink"],
      purchaseLinkCount: docSnapshot["purchaseLinkCount"],
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publishedDateTime"]
    );
  }
}