import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../server/home_video_display/home_video_controller.dart';

class HomeVideoPlayer extends StatefulWidget {
  final String videoFileUrl;
  final String purchaseLink;
  final String videoID;
  

  const HomeVideoPlayer({
    super.key,
    required this.videoFileUrl,
    required this.purchaseLink, 
    required this.videoID,
  });

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {

  VideoPlayerController? playerController;

    //controller for video display screen
  final ControllerHomeVideos controllerHomeVideos =
      Get.put(ControllerHomeVideos());


  var timestamp;

  @override
  void initState() {
    super.initState();

      playerController = VideoPlayerController.network(widget.videoFileUrl)
      ..initialize().then((value) {
        setState(() {
          timestamp = DateTime.now().millisecondsSinceEpoch;
        });
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

    if (playerController!.value.isInitialized && !playerController!.value.hasError) {
      return VisibilityDetector(
        key: Key(timestamp.toString() + "_" + widget.videoFileUrl),
        onVisibilityChanged: (VisibilityInfo info) 
        {
          var visiblePercentage = info.visibleFraction * 100;
                  if (mounted) {
                    if(playerController!.value.isInitialized){

                      if (visiblePercentage > 50) {
                      playerController!.play();
                      playerController!.setLooping(true);
                      playerController!.setVolume(2);
                      }
                      else {
                        playerController!.seekTo(const Duration(milliseconds: 0));
                        playerController!.pause();
                        }
                    }
                  }
        },
        child: Stack(
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
                  child: VideoPlayer(playerController!)
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

                //open link
                onHorizontalDragEnd: (DragEndDetails details) async {
                  if (details.primaryVelocity! < 0)
                  {
                  await controllerHomeVideos.increaseProductLinkVisitCount(widget.videoID);
                  await launchUrl(Uri.parse(widget.purchaseLink),
                  mode: LaunchMode.externalApplication);
                  }
                },

                //
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
                })
          ]
        ),
        );
    }

    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
