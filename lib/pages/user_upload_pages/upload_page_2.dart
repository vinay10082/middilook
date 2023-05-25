import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/user_upload_pages/upload_page_3.dart';
import 'package:video_player/video_player.dart';

class UploadPlayer extends StatefulWidget {

  const UploadPlayer({super.key, required this.videoFile, required this.videoPath});
  
  final File videoFile;
  final String videoPath;

  @override
  State<UploadPlayer> createState() => _UploadPlayerState();
}

class _UploadPlayerState extends State<UploadPlayer> {

  VideoPlayerController? playerController;

  @override
  void initState() {
    super.initState();
    
    setState(() {
    playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    //set looping....
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    playerController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // display video player
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  VideoPlayer(playerController!),
                  Container(
                  alignment: Alignment.bottomCenter,
                  child:FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    onPressed:() {
                    setState(() {
                      
                      if(playerController!.value.isPlaying){
                        playerController!.pause();
                      }
                      else{
                        playerController!.play();
                      }
                    });
                  },
                  child: Icon(
                    playerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  )
                  ),
                  Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero
                  ),
                  onPressed:() {
                    playerController!.pause();
                    Get.to(UploadDetail(videoFile: widget.videoFile, videoPath: widget.videoPath));
                  },
                  child: Icon(Icons.arrow_forward_ios,
                  color: Colors.white,
                  ),
                )
                  )
                    ],
                  ),
            ),
          ]
        )
      )
    );
  }
}
