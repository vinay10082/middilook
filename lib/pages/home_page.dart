import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/utils/posthome_utils/home_video_display.dart';
import 'package:video_player/video_player.dart';


import '../server/home_video_display/home_video_controller.dart';
import '../utils/posthome_utils/bottom_button.dart';
import '../utils/posthome_utils/right_button.dart';

class MyHome extends StatefulWidget {

  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  final ControllerHomeVideos controllerHomeVideos = Get.put(ControllerHomeVideos());

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

            final eachVideoInfo = controllerHomeVideos.homeAllVideosList[index];

            VideoPlayerController? playerController;

            return Stack(
              children: [
                
                //home video display
                HomeVideoPlayer(videoFileUrl: eachVideoInfo.videoUrl.toString()),

                //left side part
                  Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 100.0),
          child: Container(alignment: Alignment(1,1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
              icon: Icons.link,
              text: '201',
              ),
              MyButton(
              icon: Icons.send_outlined,
              text: 'Share',
              ),

            ],
            ),
          ),
        ),

        //left side part
                  Padding(padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 100.0),
          child: Container(
            alignment: Alignment(-1, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('@'+ "vinay",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
                SizedBox(
                  height: 10,
                ),
                RichText(text: TextSpan(
                  children: [
                    TextSpan(text: "this is review video", style: TextStyle(color: Colors.white)),
                    TextSpan(text: '#flutter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ]
                   ))
              ]),
            ),
          ),

              ],
            );
          }
          ),
          );
      }),

      //this bottom button
      Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(padding: EdgeInsets.only(bottom: 10.0),
            child: BottomButton(
              bottomicon: Icons.add_box,
              )
            )
        ),

        //this is option button
        Container(
          child: IconButton(
            onPressed: () {
              
            },
            icon: Icon(Icons.list_outlined),
            iconSize: 30,
            padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
            )
        ),
        ],
      )
    );
  }
}
//       Obx(() {
//         return PageView.builder(
//           itemCount: controllerHomeVideos.homeAllVideosList.length,
//           controller: PageController(initialPage: 0, viewportFraction: 1),
//           scrollDirection: Axis.vertical,
//           itemBuilder: ((context, index) {

//             final eachVideoInfo = controllerHomeVideos.homeAllVideosList[index];

//             playerController = VideoPlayerController.network(eachVideoInfo.videoUrl.toString())
//             ..initialize().then((value) {

//               playerController!.play();
//               playerController!.setLooping(true);
//               playerController!.setVolume(2);
//             });
            
//             return Stack(
//               children: [

//                 //video Display
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                   ),
//                   child: VideoPlayer(playerController!),
//                   ),

//         //           //right side button
//         //           Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 100.0),
//         //   child: Container(alignment: Alignment(1,1),
//         //   child: Column(
//         //     mainAxisAlignment: MainAxisAlignment.end,
//         //     children: [
//         //       MyButton(
//         //       icon: Icons.link,
//         //       text: '201',
//         //       ),
//         //       MyButton(
//         //       icon: Icons.send_outlined,
//         //       text: 'Share',
//         //       ),

//         //     ],
//         //     ),
//         //   ),
//         // ),
        
//                   //left side button
//           //         Padding(padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 100.0),
//           // child: Container(
//           //   alignment: Alignment(-1, 1),
//           //   child: Column(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //     mainAxisAlignment: MainAxisAlignment.end,
//           //     children: [
//           //       Text('@'+ username,
//           //       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
//           //       SizedBox(
//           //         height: 10,
//           //       ),
//           //       RichText(text: TextSpan(
//           //         children: [
//           //           TextSpan(text: description, style: TextStyle(color: Colors.white)),
//           //           TextSpan(text: '#flutter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//           //         ]
//           //          ))
//           //     ]),
//           //   ),
//           // ),

//       //     //bottom side button
//       // Align(
//       //   alignment: FractionalOffset.bottomCenter,
//       //   child: Padding(padding: EdgeInsets.only(bottom: 10.0),
//       //       child: BottomButton(
//       //         bottomicon: Icons.add_box,
//       //         )
//       //       )
//       //   ),
//           ],
//         );
//       }),
//     );
//       }
//       ),
//     );

//   }
// }
