import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/authentication_page/signup_page.dart';
import 'package:middilook/server/authentication/authentication_controller.dart';
import 'package:middilook/utils/default_widget/input_text_widget.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../../global.dart';

class MyLoginAuth extends StatefulWidget {
  const MyLoginAuth({super.key});

  @override
  State<MyLoginAuth> createState() => _MyLoginAuthState();
}

class _MyLoginAuthState extends State<MyLoginAuth> {
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
              'Log In',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                            //login user now
                            if (emailTextEditingController.text.isNotEmpty &&
                                passwordTextEditingController.text.isNotEmpty) {
                              setState(() {
                                showProgressBar = true;
                              });

                              authenticationController.loginUseNow(
                                emailTextEditingController.text,
                                passwordTextEditingController.text,
                              );
                            }
                          },
                          child: const Center(
                              child: Text(
                            'Log In',
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
                          const Text("Don't have an Account? "),
                          InkWell(
                            onTap: () {
                              //send the user to signup screen
                              Get.to(MySignupAuth());
                            },
                            child: const Text("Signup now",
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
