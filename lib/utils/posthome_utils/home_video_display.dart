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

bool _showPlayPauseButton = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
    Container(
      padding: EdgeInsets.fromLTRB(0, 40, 0, 60),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: VideoPlayer(playerController!),
    ),

    //GestureDetector(child: Container(...), onTap: () { _show = true; })
    GestureDetector(
      child: Container(
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: _showPlayPauseButton? Icon(
                    playerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  )
                  : null,
                ), onTap:(){ 
                  setState(() {
                      
                      if(playerController!.value.isPlaying){
                        playerController!.pause();
                      }
                      else{
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
                  })

      ],
    );
  }
}