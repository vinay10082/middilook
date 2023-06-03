import 'dart:async';

import 'package:flutter/material.dart';
import 'package:middilook/global.dart';
import 'package:middilook/utils/default_widget/input_text_widget.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../server/authentication/authentication_controller.dart';

class MyPhoneAuth extends StatefulWidget {
  const MyPhoneAuth({super.key});

  @override
  State<MyPhoneAuth> createState() => _MyPhoneAuthState();
}

class _MyPhoneAuthState extends State<MyPhoneAuth> {

  TextEditingController phoneTextEditingController = TextEditingController();

  int start = 30;
  bool isOtpSent1 = false;
  bool isOtpSent2 = false;

  var authenticationController = AuthenticationController.instanceAuth;

  String smsCode = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
              height: 100,
            ),
            const Text(
              'MIDDILOOK',
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Phone Verification',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),

            //phone number input
            InputTextWidget(
              textEditingController: phoneTextEditingController,
              lableString: 'Phone Number',
              iconData: Icons.phone_iphone_outlined,
              isObscure: false,
              limit: 10,
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
                        width: MediaQuery.of(context).size.width-200,
                        height: 54,
                        child: 
                        !isOtpSent1 ?
                        InkWell(
                          onTap: () {
                            //login user now
                            if (phoneTextEditingController.text.isNotEmpty) {
                            // Get.snackbar("Otp Sent", "fill the 6-digit otp. if not get,wait for 30 sec, press send otp button again");
                            
                            //get verification code
                            authenticationController.verifyPhoneNumber("+91 ${phoneTextEditingController.text}");
                            
                            
                            //start timer
                            setState(() {
                              isOtpSent1 = true;
                              isOtpSent2 = true;
                            });
                            const onSec = Duration(seconds: 1);
                            Timer.periodic(onSec, (timer) {
                              if(start == 0){
                                setState(() {
                                  timer.cancel();
                                  isOtpSent1 = false;
                                  start = 30;
                                });
                              }
                              else{
                                setState(() {
                                  start--;
                                });
                              }
                             });
                            }
                          },
                          child: const Center(
                              child: Text(
                            'Send Otp',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ) 
                        : Center(
                          child: Text("00:$start sec", style: const TextStyle(color: Colors.grey,))
                        ),
                      ),
            Column(
            children: 
            isOtpSent2 ?
            <Widget>[
            const SizedBox(
              height: 60,
            ),

            Row(
              children: [
                Expanded(child: Container(
                  height: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                )),
                const Text("Enter 6-digit OTP", style: TextStyle(fontSize: 16, color: Colors.white),),
                Expanded(child: Container(
                  height: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                )),
              ],
            ),
            const SizedBox(
            height: 50,
            ),

            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width - 50,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Colors.grey,
                enabledBorderColor: Colors.grey,
                focusBorderColor: Colors.pink
              ),
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceBetween,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) 
              {
                setState(() {
                  smsCode = pin;
                });
              },
            ),

            const SizedBox(
            height: 50,
            ),

            //login button
            showProgressBar == false?
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        height: 54,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: 
                        InkWell(
                          onTap: () {

                            setState(() {
                              showProgressBar = true;
                            });
                            //login user now
                            Future.delayed(const Duration(seconds: 3),(){
                            authenticationController
                            .signinWithPhoneNumber(smsCode, "+91 ${phoneTextEditingController.text}");
                            });
                          },
                          child: const Center(
                              child: Text(
                            "Lets Go",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ) 
                      )
                      : Container(
                        child: 
                      const SimpleCircularProgressBar(
                      progressColors: [
                        Colors.pink,
                      ],
                      animationDuration: 5,
                      backColor: Colors.white38,
                    ),
                      )
                        ] : [],
                  )
            ],
          ),
        ),
      ),
    );
  }
}