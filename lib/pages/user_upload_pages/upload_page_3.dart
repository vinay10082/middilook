import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadDetail extends StatefulWidget {
  const UploadDetail({super.key});

  @override
  State<UploadDetail> createState() => _UploadDetailState();
}

class _UploadDetailState extends State<UploadDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'video description here',
              labelText: 'Description'
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('Select Stores and paste your product link below'),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                IconButton(
                onPressed:() {
                launch('https://www.amazon.in/gp/css/order-history');
                },
                icon: Image.asset('lib/assets/amazon.png'),
                 ),
                IconButton(
                onPressed:() {
                launch('https://www.flipkart.com/rv/orders');
                },
                icon: Image.asset('lib/assets/flipkart.png'),
                 ),
                IconButton(
                onPressed:() {
                launch('https://smo.shopclues.com/myorders');
                },
                icon: Image.asset('lib/assets/shopclues.png'),
                 ),
                ]
              ),
              TableRow(
                children: [
                IconButton(
                onPressed:() {
                launch('https://m.snapdeal.com/myorders');
                },
                 icon: Image.asset('lib/assets/snapdeal.png'),
                 ),
                IconButton(
                onPressed:() {
                launch('https://www.myntra.com/my/orders');
                },
                 icon: Image.asset('lib/assets/myntra.png'),
                 ),
                IconButton(
                onPressed:() {
                launch('https://www.ajio.com/my-account/orders');
                },
                 icon: Image.asset('lib/assets/ajio.png'),
                 ),
                ]
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Product link here "https://..."',
              labelText: 'Paster URL'
            ),
          ),
          FloatingActionButton.extended(
            onPressed:() {
              Get.off(MyHome());
            },
            label: Text('Create'),
            backgroundColor: Colors.grey,
          )
        ],
      ),
    );
  }
}