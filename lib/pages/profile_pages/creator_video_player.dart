import 'package:flutter/material.dart';

class CreatorVideoPlayer extends StatefulWidget {
  const CreatorVideoPlayer({super.key});

  @override
  State<CreatorVideoPlayer> createState() => _CreatorVideoPlayerState();
}

class _CreatorVideoPlayerState extends State<CreatorVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("this is creator video player")),
    );
  }
}
