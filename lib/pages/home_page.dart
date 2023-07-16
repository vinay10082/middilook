import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';
import '../global.dart';
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

  SharedPreferences preferences;

  displayShowCase() async {
    preferences = await SharedPreferences.getInstance();

    bool? showCaseVisibilityStatus = preferences.getBool("displayshowcase");

    if(showCaseVisibilityStatus == null){
      preferences.setBool("displayshowcase", false);
      return true;
    }
    return false;
  }

  displayShowCase().then((status) {
    if(status) {
      ShowCaseWidget.of(context).startShowCase([
      key1,
      key2,
      key3,
      key4
    ]);
    }
  });

    return  Scaffold( 
      body: Container(
      child: Showcase.withWidget(
      key: key4,
      height: 100,
      width: 100,
      targetPadding: const EdgeInsets.symmetric(vertical: -650),
      tooltipPosition: TooltipPosition.top,
      container: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset('lib/assets/swipe_left.png'),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            width: 150,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.white),
            child: const Text('Swipe left to purchase product', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,),),
          ),
        ]
      ),
      child: Stack(
      children: [
        Obx(() {
          return PreloadPageView.builder(
      itemCount: controllerHomeVideos.homeAllVideosList.length,
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {

      final eachVideoInfo = controllerHomeVideos.homeAllVideosList[index];

          return Stack(
                children: [
                  //home video display
                  HomeVideoPlayer(
                      videoFileUrl: eachVideoInfo.videoUrl.toString(),
                      purchaseLink: eachVideoInfo.purchaseLink.toString(),
                      videoID: eachVideoInfo.videoID.toString(),
                      ),
                  
                  //left side part
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 70),
                    child:  
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: const Alignment(-1, 1),
                      child: Stack(children: [

                        RichText(
                            text: TextSpan(
                                  text: eachVideoInfo.description.toString(),
                                  style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                                )
                          ),
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
      preloadPagesCount: 6,
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
    ),
    )
      ),
  );
}
}