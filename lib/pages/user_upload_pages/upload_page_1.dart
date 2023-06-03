import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/user_upload_pages/upload_page_2.dart';
import 'package:video_trimmer/video_trimmer.dart';

import '../../global.dart';

class UploadPlayer extends StatefulWidget {
  const UploadPlayer(
      {super.key,
      required this.videoFile,
      required this.videoPath,
      required this.thumbnailImage});

  final File? videoFile;
  final String videoPath;
  final File thumbnailImage;

  @override
  State<UploadPlayer> createState() => _UploadPlayerState();
}

class _UploadPlayerState extends State<UploadPlayer> {
  final Trimmer _trimmer = Trimmer();

  String? trimmedVideoPath;

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  void _loadVideo() {
    _trimmer.loadVideo(videoFile: widget.videoFile!);
    setState(() {
      isVideoCompressing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 40,
        ),

        //this is trimmer viewer
        Container(
          alignment: Alignment.topCenter,
          child: TrimViewer(
            trimmer: _trimmer,
            viewerHeight: 50,
            viewerWidth: MediaQuery.of(context).size.width,
            maxVideoLength: const Duration(seconds: 30),
            onChangeStart: (value) => _startValue = value,
            onChangeEnd: (value) => _endValue = value,
            onChangePlaybackState: (value) =>
                setState(() => _isPlaying = value),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        //this is video player section
        Expanded(
          child: VideoViewer(trimmer: _trimmer),
        ),
        Visibility(
          visible: _progressVisibility,
          child: const LinearProgressIndicator(backgroundColor: Colors.red),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                //this is play pause button
                Container(
                  alignment: Alignment.center,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    onPressed: () async {
                      bool playbackState = await _trimmer.videoPlaybackControl(
                          startValue: _startValue, endValue: _endValue);

                      setState(() {
                        _isPlaying = playbackState;
                      });
                    },
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),

                //this is upload button
                Container(
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      shape: const BeveledRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      onPressed: _progressVisibility
                          ? null
                          : () async {
                              setState(() {
                                _progressVisibility = true;
                              });

                              await _trimmer.saveTrimmedVideo(
                                  startValue: _startValue,
                                  endValue: _endValue,
                                  onSave: (outputPath) {
                                    setState(() {
                                      _progressVisibility = false;
                                      trimmedVideoPath = outputPath;
                                      Get.to(UploadDetail(
                                          trimmedVideoPath: outputPath!,
                                          thumbnailImage:
                                              widget.thumbnailImage));
                                      // Get.snackbar("path", outputPath!);
                                    });
                                  });
                            },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ))
              ],
            ))
      ],
    ));
  }
}
