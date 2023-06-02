import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
import 'package:video_player/video_player.dart';

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
    return Scaffold(
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

              VideoPlayerController? playerController;

              return Stack(
                children: [
                  //home video display
                  HomeVideoPlayer(
                      videoFileUrl: eachVideoInfo.videoUrl.toString(),
                      purchaseLink: eachVideoInfo.purchaseLink.toString()),

                  // //right side part
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 60.0),
                  //   child: Container(
                  //     alignment: Alignment(1, 1),
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         //   //this is purchase link button
                  //         //   Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                  //         //   child: Column(children: [
                  //         //   IconButton(
                  //         //     onPressed: ()
                  //         //     async {
                  //         //       //this is open purchase link
                  //         //       // if(await canLaunchUrl(Uri.parse(eachVideoInfo.purchaseLink.toString())))
                  //         //       // {
                  //         //       await launchUrl(Uri.parse(eachVideoInfo.purchaseLink.toString()), mode: LaunchMode.externalApplication);
                  //         //       // }
                  //         //       // else
                  //         //       // {
                  //         //         // Get.snackbar("The Link is not Correct", "or The Link is Dead");
                  //         //       // }
                  //         //     },
                  //         //     icon: const ImageIcon(
                  //         //             AssetImage('lib/assets/goToLinkColor.png'),
                  //         //             size: 40,
                  //         //             color: Color.fromARGB(159, 255, 0, 128),
                  //         //           ),
                  //         //           // ImageIcon(
                  //         //           //   AssetImage('lib/assets/goToLink.png'),
                  //         //           //   size: 40,
                  //         //           //   color: Colors.white,
                  //         //           // ),
                  //         //     ),
                  //         //   // Text(eachVideoInfo.purchaseLinkCount.toString(), style: TextStyle(color: Colors.white)),
                  //         // ]),),

                  //         //this is sharing button
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 15.0),
                  //           child: Column(children: [
                  //             IconButton(
                  //               onPressed: () {
                  //                 // function of sharing video
                  //               },
                  // icon: const ImageIcon(
                  //   AssetImage('lib/assets/share.png'),
                  //   size: 40,
                  //   color: Colors.white,
                  // ),
                  //               // ImageIcon(
                  //               //   AssetImage('lib/assets/goToLink.png'),
                  //               //   size: 40,
                  //               //   color: Colors.white,
                  //               // ),
                  //             ),
                  //             const Text('Share',
                  //                 style: TextStyle(color: Colors.white)),
                  //           ]),
                  //         ),

                  //         // //Profile circular Animation
                  //         // CircularImageAnimation(
                  //         //   widgetAnimation: SizedBox(
                  //         //     width: 62,
                  //         //     height: 62,
                  //         //     child: Column(
                  //         //       children: [
                  //         //         Container(
                  //         //           padding: const EdgeInsets.all(12),
                  //         //           height: 52,
                  //         //           width: 52,
                  //         //           decoration: BoxDecoration(
                  //         //             gradient: const LinearGradient(
                  //         //               colors: [
                  //         //                 Colors.red,
                  //         //                 Colors.orange,
                  //         //                 Colors.yellow,
                  //         //                 Colors.green,
                  //         //                 Colors.blue,
                  //         //                 Colors.indigo,
                  //         //                 Colors.purple,
                  //         //               ]
                  //         //               ),
                  //         //             borderRadius: BorderRadius.circular(25),
                  //         //           ),
                  //         //           child: ClipRRect(
                  //         //             borderRadius: BorderRadius.circular(25),
                  //         //             child: Image.asset("lib/assets/music.png",
                  //         //               fit: BoxFit.cover,
                  //         //               ),
                  //         //             )
                  //         //           // Image(
                  //         //           //   image: NetworkImage(
                  //         //           //     eachVideoInfo.userProfileImage.toString(),
                  //         //           //   ),
                  //         //           //   )
                  //         //         )
                  //         //     ],
                  //         //     ),
                  //         //   ),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  //left side part
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0.0, 0.0, 70),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment(-1, 1),
                      child: Stack(children: [
                        // Text('@ ' + eachVideoInfo.userName.toString(),
                        // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                        // SizedBox(
                        //   height: 10,
                        // ),

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

                        //    SizedBox(
                        //   height: 10,
                        // ),

                        // Row(
                        //   children: [
                        //     const Icon(Icons.music_note_outlined),
                        //     const SizedBox(
                        //       width: 20
                        //     ),
                        //     Container(
                        //       width: MediaQuery.of(context).size.width/2,
                        //       child: const MyScrollingText(
                        //               text: "This is the song name of the short video",
                        //               textStyle: TextStyle(fontStyle: FontStyle.italic),
                        //             )
                        //     ),
                        //   ],
                        //   )
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
    ));
  }
}
