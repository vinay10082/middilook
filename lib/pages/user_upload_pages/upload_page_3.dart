import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../server/upload_video/upload_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(autocorrect: true,
            controller: descriptionTextEditingController,
            decoration: const InputDecoration(
            labelText: "Description",
            ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text("Select Stores and paste your product link below", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(
            height: 20.0,
          ),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://www.amazon.in/gp/css/order-history'));
                },
                icon: Image.asset('lib/assets/amazon.png'),
                 ),
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://www.flipkart.com/rv/orders'));
                },
                icon: Image.asset('lib/assets/flipkart.png'),
                 ),
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://smo.shopclues.com/myorders'));
                },
                icon: Image.asset('lib/assets/shopclues.png'),
                 ),
                ]
              ),
              TableRow(
                children: [
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://m.snapdeal.com/myorders'));
                },
                 icon: Image.asset('lib/assets/snapdeal.png'),
                 ),
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://www.myntra.com/my/orders'));
                },
                 icon: Image.asset('lib/assets/myntra.png'),
                 ),
                IconButton(
                onPressed:() {
                launchUrl(Uri.parse('https://www.ajio.com/my-account/orders'));
                },
                 icon: Image.asset('lib/assets/ajio.png'),
                 ),
                ]
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(autocorrect: true,
            controller: purchaseLinkTextEditingController,
            decoration: const InputDecoration(
            labelText: "Paste Link Here",
            ),
            ),
          ),
          InkWell(
            onTap: ()
            {
              if(descriptionTextEditingController.text.isNotEmpty && purchaseLinkTextEditingController.text.isNotEmpty)
              {
                uploadVideoController.saveVideoInformationToFirestoreDatabase
                (
                descriptionTextEditingController.text, 
                purchaseLinkTextEditingController.text, 
                widget.videoPath,
                context
                );
              }
              // setState(() {
              //   //for the progress bar
              // });
            },
            child: const Center(
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}