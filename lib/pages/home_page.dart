import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
import 'package:middilook/utils/showcaseview_widget/showcase_widget.dart';
import 'package:showcaseview/showcaseview.dart';

import '../server/home_video_display/home_video_controller.dart';
import '../utils/posthome_utils/bottom_buttons_bar.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  //key for show case widget
  final GlobalKey _goToProductKey = GlobalKey();

  //controller for video display screen
  final ControllerHomeVideos controllerHomeVideos =
      Get.put(ControllerHomeVideos());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      ShowCaseWidget.of(context).startShowCase(
        [
          _goToProductKey,
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return  ShowCaseWidget(
      builder: Builder(
        builder: (context) =>
        Scaffold(
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
                  ShowCaseView(
                    globalKey: _goToProductKey, 
                    title: "See the Product", 
                    description: "swipe right to left to see the Product",

                    child: 
                  HomeVideoPlayer(
                      videoFileUrl: eachVideoInfo.videoUrl.toString(),
                      purchaseLink: eachVideoInfo.purchaseLink.toString(),
                      videoID: eachVideoInfo.videoID.toString()
                      ),
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
    ))
  )
);
  }
}
