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
            //display video player
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/1.07,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  VideoPlayer(playerController!),
                  FloatingActionButton(
                    elevation: 0.0,
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
                  ),
                  )
                ]
              )
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width/1.2,
                  child: Text('video max length is 30 sec'),
                ),
                FloatingActionButton(
                  shape: ContinuousRectangleBorder(),
                  onPressed:() {
                    playerController!.pause();
                    Get.to(UploadDetail(videoFile: widget.videoFile, videoPath: widget.videoPath));
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}