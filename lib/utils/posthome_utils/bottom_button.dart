import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:middilook/pages/authentication_page/login_page.dart';

import '../../pages/user_upload_pages/upload_page_1.dart';


class BottomButton extends StatefulWidget {
  const BottomButton({super.key, this.bottomicon});

  final bottomicon;

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {

  late Rx<User?> _currentUser;

  @override
  Widget build(BuildContext context) {
    return IconButton(
              icon: Icon(widget.bottomicon),
              iconSize: 50,
              color: Colors.white, 
              onPressed: () {
                setState(() {
                  _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
                  _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
                });
                ever(_currentUser, (User? currentUser){

                  if(currentUser == null){
                    Get.to(MyLoginAuth());
                  }
                  else{
                    Get.to(UserUpload());
                  }
                });
               },
          
        );
  }
}