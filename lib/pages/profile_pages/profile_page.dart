import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/home_page.dart';
import 'package:middilook/pages/profile_pages/edit_profile_page.dart';
import 'package:middilook/server/profile/profile_controller.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> 
{
  ProfileController controllerProfile = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    
    controllerProfile.updateCurrentUserID(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controllerProfile)
      {
        if(controllerProfile.userMap.isEmpty)
        {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () 
              {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                ),
              ),
            
            title: Text("Info"),
            ),
          body: SingleChildScrollView(
            child: Column(
              children: [

                //user profile image
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    controllerProfile.userMap["userImage"],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
              controllerProfile.userMap["userName"], 
              style: const TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.white
                ),
              ),

                const SizedBox(
                  height: 16,
                ),

                //totalPurchaseLinkCount
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //totalPurchaseLinkCount widget
                    GestureDetector(
                      onTap: ()
                      {

                      },
                      child: Column(
                        children: [
                          Text(
                            controllerProfile.userMap["totalPurchaseLinkCount"],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink
                            ),
                          ),

                          const SizedBox(height: 10,),

                          const Text("Visited",
                          style: TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.pink
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                //edit profile button and signout button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: InkWell(
                        onTap: () 
                        {
                          //function to edit profilet
                          Get.to(EditProfile());
                        },
                        child: const Center(
                    child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    )
                  ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white
                      ),
                      child: InkWell(
                        onTap: () 
                        {
                          //function to sing out
                          FirebaseAuth.instance.signOut();
                          Get.offAll(MyHome());
                          Get.snackbar("Logged Out", "you are logged out from the app.");
                        },
                        child: const Center(
                    child: Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    )
                  ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                //display user's video - thumbnails
                GridView.builder(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controllerProfile.userMap["thumbnailsList"].length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index)
                    {
                      String eachThumbnailUrl = controllerProfile.userMap["thumbnailsList"][index];

                      return GestureDetector(
                        onTap:() 
                        {
                          
                        },
                          child: Image.network(
                          eachThumbnailUrl, 
                          fit: BoxFit.cover,
                        )
                      );
                    },

                )
              ],
            ),
          ),
        );
      },
    
    );
  }
}