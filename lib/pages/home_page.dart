import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
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
          return PageView.builder(
            itemCount: controllerHomeVideos.homeAllVideosList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: ((context, index) {
              final eachVideoInfo =
                  controllerHomeVideos.homeAllVideosList[index];

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
            }),
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
                Text("Hi there! Welcome to our app.")

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
