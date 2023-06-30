import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../server/home_video_display/home_video_controller.dart';
import '../utils/posthome_utils/bottom_buttons_bar.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  //controller for video display screen
  final ControllerHomeVideos controllerHomeVideos =
      Get.put(ControllerHomeVideos());


  @override
  Widget build(BuildContext context) {

    return  Scaffold( 
      body: Stack(
      children: [
        Obx(() {
          return PreloadPageView.builder(
      itemCount: controllerHomeVideos.homeAllVideosList.length,
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

      final eachVideoInfo = controllerHomeVideos.homeAllVideosList[index];

          return Stack(
                children: [
                  //home video display
                  HomeVideoPlayer(
                      videoFileUrl: eachVideoInfo.videoUrl.toString(),
                      purchaseLink: eachVideoInfo.purchaseLink.toString(),
                      videoID: eachVideoInfo.videoID.toString()
                      ),
                    

                  //left side part
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 70),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: const Alignment(-1, 1),
                      child: Stack(children: [

                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: eachVideoInfo.description.toString(),
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          // TextSpan(text: ' #flutter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontStyle: FontStyle.italic)),
                        ])),
                      ]),
                    ),
                  ),
                ],
              );
        },
      onPageChanged: (int position) 
      {
        print("Hello World");
        print(position);
      },
      preloadPagesCount: 3,
      controller: PreloadPageController(initialPage: 0),
    );
  }),
        //this bottom button
        Container(
            alignment: Alignment.bottomCenter,
            child: const MyBottomButtonBar(
              profileicon: Icons.person,
              uploadicon:
                  // Icon(Icons.add_outlined),
                  ImageIcon(
                AssetImage('lib/assets/add_box.png'),
                color: Colors.white,
              ),
              searchicon: Icon(Icons.search),
            ))
      ],
    )
  );
}
}

//this is onboarding page
class MyOnbordingScreen extends StatefulWidget {
  const MyOnbordingScreen({super.key});

  @override
  State<MyOnbordingScreen> createState() => _MyOnbordingScreenState();
}

class _MyOnbordingScreenState extends State<MyOnbordingScreen> {
  final _onboardingController = PageController();

  bool isLastPage = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: _onboardingController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2;
            });
          },
          children: [
            Container(
              child: Column(
                children: [
                SizedBox(
                  height: 300,
                ),
                Text("Welcome", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.pink),),
                SizedBox(
                  height: 30,
                ),
                Text("Hi there! Welcome to our app"),
                SizedBox(
                  height: 20,
                ),
AnimatedTextKit(
  animatedTexts: [
    ColorizeAnimatedText(
      'Add link and get reward',
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      colors: [Colors.white, Colors.pink,],
      speed: const Duration(milliseconds:80),
    ),
  ],
  
  isRepeatingAnimation: false,
)

                ],
                )
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text("Add Video Button", style: TextStyle(fontSize: 20),),
                  Container(
                    child: Image.asset("lib/assets/bottom_add.png"),
                  ),
                  Text("Profile Button", style: TextStyle(fontSize: 20),),
                  Container(
                    child: Image.asset("lib/assets/bottom_profile.png"),
                  ),
                  Text("Search Video Button", style: TextStyle(fontSize: 20),),
                  Container(
                    child: Image.asset("lib/assets/bottom_search.png"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                  height: 200,
                ),
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.asset("lib/assets/rightSwipe.png")
                  ),
                SizedBox(
                  height: 30,
                ),
                Text("Go To Product Page", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.pink),),
                SizedBox(
                  height: 30,
                ),
                Text("Swipe right to Left to open Product Page."),
                ]
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 70,
        child: 
        isLastPage ?
        TextButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('showHome', true);
          Get.offAll(MyHome());
        }, 
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          minimumSize: const Size.fromHeight(80)
        ),
        child: const Center(child: Text("Get Started", style: TextStyle(fontSize: 24, color: Colors.black),),)
        ) 
        : SmoothPageIndicator(
                controller: _onboardingController, 
                count: 3,
                effect: const WormEffect(
                  activeDotColor: Colors.pink
                  ),
                onDotClicked: (index) => _onboardingController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeIn),
                ),
      ),
    );
  }
}

// import 'dart:async';
// import 'dart:developer';
// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MyHome extends StatefulWidget {
//   const MyHome({super.key});

//   @override
//   State<MyHome> createState() => _MyHomeState();
// }

// class _MyHomeState extends State<MyHome> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: BlocBuilder<PreloadBloc, PreloadState>(
//           builder: (context, state) {
//             return PageView.builder(
//               itemCount: state.urls.length,
//               scrollDirection: Axis.vertical,
//               onPageChanged: (index) => BlocProvider.of<PreloadBloc>(context)
//               .add(PreloadEvent.onVideoIndexChanged(index)),
//               itemBuilder: (context, index) {
//                 return state.focusedIndex == index
//                 ? VideoPlayer(State.controllers[index]!)
//                 : const SizedBox();
//               },
//               );
//           }
//         )
//       ),
//       );
//   }
// }
// 
// @freezed
// class PreloadEvent with _$PreloadEvent {
// const factory PreloadEvent.initialize() = _Initialize;
// const factory PreloadEvent.onVideoIndexChanged(int index) = _OnVideoIndexChanged;
// }

// @freezed
// class PreloadState with _$PreloadState {
// const factory PreloadState({
// required List<String> urls,
// required Map<int, VideoPlayerController> controllers,
// required int focusedIndex,
// }) = _PreloadState;
// factory PreloadState.initial() => PreloadState(
// focusedIndex: 0,
// urls: const [
// 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4#1',
// 'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
// 'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
// 'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
// ],
// controllers: {},
// );
// }

// class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
// PreloadBloc() : super(PreloadState.initial());
// @override
// Stream<PreloadState> mapEventToState(
// PreloadEvent event,
// ) async* {
// yield* event.map(
// initialize: (e) async* {
// /// Initialize 1st video
// await _initializeControllerAtIndex(0);
// /// Play 1st video
// _playControllerAtIndex(0);
// /// Initialize 2nd vide
// await _initializeControllerAtIndex(1);
// },
// onVideoIndexChanged: (e) async* {
// if (e.index > state.focusedIndex) {
// _playNext(e.index);
// } else {
// _playPrevious(e.index);
// }
// yield state.copyWith(focusedIndex: e.index);
// },
// );
// }
// void _playNext(int index) {
// /// Stop [index - 1] controller
// _stopControllerAtIndex(index - 1);
// /// Dispose [index - 2] controller
// _disposeControllerAtIndex(index - 2);
// /// Play current video (already initialized)
// _playControllerAtIndex(index);
// /// Initialize [index + 1] controller
// _initializeControllerAtIndex(index + 1);
// }
// void _playPrevious(int index) {
// /// Stop [index + 1] controller
// _stopControllerAtIndex(index + 1);
// /// Dispose [index + 2] controller
// _disposeControllerAtIndex(index + 2);
// /// Play current video (already initialized)
// _playControllerAtIndex(index);
// /// Initialize [index - 1] controller
// _initializeControllerAtIndex(index - 1);
// }
// Future _initializeControllerAtIndex(int index) async {
// if (state.urls.length > index && index >= 0) {
// /// Create new controller
// final VideoPlayerController _controller =
// VideoPlayerController.network(state.urls[index]);
// /// Add to [controllers] list
// state.controllers[index] = _controller;
// /// Initialize
// await _controller.initialize();
// log('🚀🚀🚀 INITIALIZED $index');
// }
// }
// void _playControllerAtIndex(int index) {
// if (state.urls.length > index && index >= 0) {
// /// Get controller at [index]
// final VideoPlayerController _controller = state.controllers[index]!;
// /// Play controller
// _controller.play();
// log('🚀🚀🚀 PLAYING $index');
// }
// }
// void _stopControllerAtIndex(int index) {
// if (state.urls.length > index && index >= 0) {
// /// Get controller at [index]
// final VideoPlayerController _controller = state.controllers[index]!;
// /// Pause
// _controller.pause();
// /// Reset postiton to beginning
// _controller.seekTo(const Duration());
// log('🚀🚀🚀 STOPPED $index');
// }
// }
// void _disposeControllerAtIndex(int index) {
// if (state.urls.length > index && index >= 0) {
// /// Get controller at [index]
// final VideoPlayerController _controller = state.controllers[index]!;
// /// Dispose controller
// _controller.dispose();
// state.controllers.remove(_controller);
// log('🚀🚀🚀 DISPOSED $index');
// }
// }
// }