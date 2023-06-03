import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:middilook/server/profile/profile_controller.dart';
import 'package:middilook/utils/default_widget/input_text_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String userName = "";
  String userImageUrl = "";

  TextEditingController userNameTextEditingController = TextEditingController();

//instance for the profile controller
  ProfileController controllerProfile = Get.put(ProfileController());

  String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  File? profileImage;

  getCurrentUserData() async {
    DocumentSnapshot snapshotUser = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get();
    
    userName = snapshotUser["name"];
    userImageUrl = snapshotUser["image"];

    setState(() {
      userNameTextEditingController.text = userName ?? "";
    });
  }

  @override
  void initState() {
    super.initState();

    getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controllerProfile) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile Settings"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
                child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text("Update Your Profile Image."),
                const SizedBox(
                  height: 30,
                ),
                //profile Image edit
                GestureDetector(
                    onTap: () async {
                      final pickedImageFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      
                      if (pickedImageFile != null) {
                        profileImage =
                            Rx<File?>(File(pickedImageFile.path)).value;

                        Get.snackbar("profile Image",
                            "You have successfully selected your profile image.");
                      }
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: const Color.fromARGB(143, 158, 158, 158),
                      backgroundImage: NetworkImage(
                        controllerProfile.userMap["userImage"],
                      ),
                    )),

                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.snackbar("Wait", "Take more time as usual");
                      controllerProfile.updateCurrentUserProfilePhoto(
                        profileImage!,
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )),

                const SizedBox(
                  height: 30,
                ),

                const Text("Update Your Profile Detail"),

                const SizedBox(
                  height: 30,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                    textEditingController: userNameTextEditingController,
                    lableString: "User Name",
                    isObscure: false,
                    iconData: Icons.person_outline,
                    limit: 11,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.snackbar("Wait", "Take more time as usual");
                      controllerProfile.updateCurrentUserName(
                        userNameTextEditingController.text,
                      );
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    child: const Text(
                      "Update",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ))
              ],
            )),
          ),
        );
      },
    );
  }
}
