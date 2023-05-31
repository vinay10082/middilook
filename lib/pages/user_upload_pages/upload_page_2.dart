import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global.dart';
import '../../server/upload_video/upload_controller.dart';
import '../../utils/default_widget/input_text_widget.dart';

class UploadDetail extends StatefulWidget {
  const UploadDetail({super.key, required this.videoFile, required this.videoPath});
  
  final File videoFile;
  final String videoPath;

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {

  UploadController uploadVideoController = Get.put(UploadController());
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController purchaseLinkTextEditingController = TextEditingController();


  List<List<String>> stores = 
  [
    [
      'lib/assets/amazon.png',
      "https://www.amazon.in/gp/css/order-history",
    ],
    [
      'lib/assets/shopclues.png',
      "https://smo.shopclues.com/myorders",
    ],
    [
      'lib/assets/flipkart.png',
      "https://www.flipkart.com/rv/orders",
  ],
    [
      'lib/assets/snapdeal.png',
      "https://m.snapdeal.com/myorders",
  ],
    [
      'lib/assets/myntra.png',
      "https://www.myntra.com/my/orders",
  ],
    [
      'lib/assets/ajio.png',
      "https://www.ajio.com/my-account/orders",
  ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child:Column(
        children: [

          const SizedBox(height: 30,),
          //decription input field
          InputTextWidget(textEditingController: descriptionTextEditingController, lableString: 'Description', iconData: Icons.description, isObscure: false,),
          
          const SizedBox(height: 30,),
          //Stores grid
          const Text(
                "Select Stores and paste your product link below", 
                textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 25,
                fontStyle: FontStyle.italic
                )
              ),
          const SizedBox(height: 30,),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: GridView.builder(
                  itemCount: stores.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // childAspectRatio: 0.6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {

              
              return GestureDetector(
                onTap: () 
                {
                  launchUrl(Uri.parse(stores[index][1]));
                },
                child: Image.asset(stores[index][0], fit: BoxFit.fill,),
              );
            },
          ),
              ),

          const SizedBox(height: 30,),
          //product link input field
          InputTextWidget(textEditingController: purchaseLinkTextEditingController, lableString: 'Paste Link Here', iconData: Icons.link, isObscure: false,),

          const SizedBox(height: 30,),
          //create button
          showProgressBar == false ?
          Container(
            color: Colors.white,
            height: 56,
            width: MediaQuery.of(context).size.width/1.15,
            child: InkWell(
              onTap: () 
              {
              if(descriptionTextEditingController.text.isNotEmpty && purchaseLinkTextEditingController.text.isNotEmpty)
              {
              setState(() {
                //for the progress bar
                showProgressBar = true;
              });
                uploadVideoController.saveVideoInformationToFirestoreDatabase
                (
                descriptionTextEditingController.text, 
                purchaseLinkTextEditingController.text, 
                widget.videoPath,
                context
                );
              }
              },
              child: const Center(
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ) : Container(
                
                //show progress bar
                child: const SimpleCircularProgressBar(
                  progressColors: [
                    Colors.pink,
                  ],
                  animationDuration: 3,
                  backColor: Colors.white38,
                ),
              ),
        
          const SizedBox(height: 50,),
        ],
      ),
      ),
    );
  }
}