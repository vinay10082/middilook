import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeVideoPlayer extends StatefulWidget {
  
  final String videoFileUrl;

  HomeVideoPlayer({required this.videoFileUrl,});

  @override
  State<HomeVideoPlayer> createState() => _HomeVideoPlayerState();
}

class _HomeVideoPlayerState extends State<HomeVideoPlayer> {

  VideoPlayerController? playerController;

  @override
  void initState() {
    super.initState();
    
    playerController = VideoPlayerController.network(widget.videoFileUrl)
    ..initialize().then((value) {
      playerController!.play();
      playerController!.setLooping(true);
      playerController!.setVolume(2);
    });

    @override
    void dispose() {
      super.dispose();

      playerController!.dispose();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(playerController!),
    );
  }
}