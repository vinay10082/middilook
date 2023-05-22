//video modals
import 'package:cloud_firestore/cloud_firestore.dart';

class Video
{
  String? userID;
  String? userName;
  String? videoID;
  int? totalComments;
  List? likesList;
  int? totalShares;
  String? artistSongName;
  String? description;
  String? purchaseLink;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;

  Video({
    this.userID,
    this.userName,
    this.videoID,
    this.totalComments,
    this.likesList,
    this.totalShares,
    this.artistSongName,
    this.description,
    this.purchaseLink,
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
    "totalShares": totalShares,
    "artistSongName": artistSongName,
    "description": description,
    "purchaseLink": purchaseLink,
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
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publishedDateTime"]
    );
  }
}