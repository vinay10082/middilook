import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/profile_pages/profile_page.dart';
import 'package:middilook/utils/default_widget/alert_dialog_widget.dart';
import 'package:video_player/video_player.dart';

import '../../server/profile/profile_controller.dart';

class CreatorVideoPlayer extends StatefulWidget {
  const CreatorVideoPlayer({
    super.key, 
    required this.videoUrl, 
    required this.videoVisitedCount, 
    required this.videoID
    });

  final String videoUrl;
  final String videoVisitedCount;
  final String videoID;

  @override
  State<CreatorVideoPlayer> createState() => _CreatorVideoPlayerState();
}

class _CreatorVideoPlayerState extends State<CreatorVideoPlayer> {
  //controller for video display screen
  ProfileController controllerProfile = Get.put(ProfileController());

  VideoPlayerController? playerController;

  bool isPlayerInitialized = true;

  @override
  void initState() {
    super.initState();

    playerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        setState(() {
          isPlayerInitialized = false;
        });

        playerController!.play();
        playerController!.setLooping(true);
        playerController!.setVolume(2);
      });
  }

  @override
  void dispose() {
    super.dispose();

    playerController!.dispose();
  }

  bool _showPlayPauseButton = false;

  @override
  Widget build(BuildContext context) {

    if (isPlayerInitialized == false && !playerController!.value.hasError) {
      return Stack(
          // children: (playerController!.value.isInitialized && !playerController!.value.hasError)?
          children: <Widget>[
            Container(
              // padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: AspectRatio(
                  aspectRatio: playerController!.value.aspectRatio,
                  child: VideoPlayer(playerController!),
                ),
              ),
            ),

            //GestureDetector(child: Container(...), onTap: () { _show = true; })
            GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: _showPlayPauseButton
                      ? Icon(
                          playerController!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        )
                      : null,
                ),
                onTap: () {
                  setState(() {
                    if (playerController!.value.isPlaying) {
                      playerController!.pause();
                    } else {
                      playerController!.play();
                    }
                  });
                  //show pause and play button
                  setState(() {
                    _showPlayPauseButton = true;
                  });
                  //hide again pause and play button
                  Future.delayed(const Duration(seconds: 1)).then((_) {
                    setState(() {
                      _showPlayPauseButton = false;
                    });
                  });
                }),

                Container(
                  padding: const EdgeInsets.only(bottom: 60),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget> [
                      const Icon(Icons.add_link_rounded, size: 40,),

                      Text(widget.videoVisitedCount+" ", style: const TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 20)),
                      
                      const SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.bottomCenter,
                        color: Color.fromARGB(41, 255, 255, 255),
                        child: GestureDetector(
                          child: const Center(
                            child: Icon(Icons.delete, size: 40,),
                          ),
                          onTap: () {
                            //delete video function
                            showDialog(
                              context: context, 
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialogBox(
                                  alertTitle: 'Delete Video',
                                  alertContent: 'Are you sure you want to delete this video ?',
                                  alertAction: 'Delete',
                                  actionFunction: () async {
                                    try 
                                    {
                                    //delete thumbnail from storage
                                    await FirebaseStorage.instance
                                    .ref()
                                    .child("All Videos")
                                    .child(widget.videoID)
                                    .delete();

                                    //delete video from storage
                                    await FirebaseStorage.instance
                                    .ref()
                                    .child("All Thumbnails")
                                    .child(widget.videoID)
                                    .delete();

                                    //function to delete the video database
                                    await FirebaseFirestore.instance
                                    .collection('videos')
                                    .doc(widget.videoID)
                                    .delete();

                                    Get.snackbar("Video Deleted Successfully", "we have deleted this video parmanently from your account.");

                                    Get.off(MyProfile());
                                    } 
                                    catch (e) 
                                    {
                                    Get.snackbar("Unable to delete", "There is error occur while deleting video.");
                                    Get.off(MyProfile());
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
          ]
          );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
