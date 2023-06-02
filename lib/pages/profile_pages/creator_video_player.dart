import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../server/profile/profile_controller.dart';

class CreatorVideoPlayer extends StatefulWidget {
  const CreatorVideoPlayer({super.key, required this.videoUrl, required this.videoVisitedCount});

  final String videoUrl;
  final String videoVisitedCount;

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
                  Future.delayed(Duration(seconds: 1)).then((_) {
                    setState(() {
                      _showPlayPauseButton = false;
                    });
                  });
                }),
                Container(
                  // child: Center(
                  //   child: Text(widget.videoVisitedCount),
                  // ),
                  padding: const EdgeInsets.only(top: 50, left: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                      Text(widget.videoVisitedCount, style: const TextStyle(fontSize: 20, color: Colors.white,decoration: TextDecoration.none, fontWeight: FontWeight.bold),),
          
                      const SizedBox(height: 10,),

                      const Text("Visited", style: TextStyle(fontSize: 10, color: Colors.white, decoration: TextDecoration.none),)
                     
                    ],
                  ),
                )
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
