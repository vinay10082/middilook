import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/server/authentication/authentication_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../global.dart';
import '../../utils/default_widget/input_text_widget.dart';
import 'login_page.dart';

class MySignupAuth extends StatefulWidget {
  const MySignupAuth({super.key});

  @override
  State<MySignupAuth> createState() => _MySignupAuthState();
}

class _MySignupAuthState extends State<MySignupAuth> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;

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
            // Image.asset('lib/assets/logo_icon.png', width: 100,),
            // const SizedBox(height: 50,),
            Text(
              'MIDDILOOK',
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),

            Text(
              'Create an account',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),

            // //profile avatar
            // GestureDetector(
            //   onTap: () {
            //     //allow user to choose image from gallery
            //     authenticationController.chooseImageFromGallery();
            //   },
            //   child: const CircleAvatar(
            //     radius: 50,
            //     backgroundImage: AssetImage("lib/assets/profile.png"),
            //   ),
            // ),

            // const SizedBox(
            //   height: 30,
            // ),

            //username input
            InputTextWidget(
              textEditingController: userNameTextEditingController,
              lableString: 'User Name',
              iconData: Icons.person_4_outlined,
              isObscure: false,
              limit: 10,
            ),

            const SizedBox(
              height: 30,
            ),

            //email input
            InputTextWidget(
              textEditingController: emailTextEditingController,
              lableString: 'Email',
              iconData: Icons.email_outlined,
              isObscure: false,
              limit: 30,
            ),

            const SizedBox(
              height: 30,
            ),

            //password input
            InputTextWidget(
              textEditingController: passwordTextEditingController,
              lableString: 'Password',
              iconData: Icons.lock_outline,
              isObscure: true,
              limit: 200,
            ),

            const SizedBox(
              height: 30,
            ),

            //login button
            //not have an account, signup now button
            showProgressBar == false
                ? Column(
                    children: [
                      //login button
                      Container(
                        width: MediaQuery.of(context).size.width - 40,
                        height: 54,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            if (
                                // authenticationController.profileImage != null &&
                                userNameTextEditingController.text.isNotEmpty &&
                                    emailTextEditingController
                                        .text.isNotEmpty &&
                                    passwordTextEditingController
                                        .text.isNotEmpty) {
                              //to show progress bar
                              setState(() {
                                showProgressBar = true;
                              });

                              //Create a new account for user
                              authenticationController.createAccountForNewUser(
                                  // authenticationController.profileImage!,
                                  userNameTextEditingController.text,
                                  emailTextEditingController.text,
                                  passwordTextEditingController.text);
                            }
                          },
                          child: const Center(
                              child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //not have an account, signup now button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an Account? "),
                          InkWell(
                            onTap: () {
                              //send the user to signup screen
                              Get.to(MyLoginAuth());
                            },
                            child: const Text("Login now",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      )
                    ],
                  )
                : Container(
                    //show progress bar
                    child: const SimpleCircularProgressBar(
                      progressColors: [
                        Colors.pink,
                      ],
                      animationDuration: 3,
                      backColor: Colors.white38,
                    ),
                  )
          ],
        ),
      )),
    );
  }
}
