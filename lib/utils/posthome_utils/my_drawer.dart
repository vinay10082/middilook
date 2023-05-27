import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:middilook/pages/profile_pages/profile_pages.dart';
import 'package:middilook/pages/setting_pages/setting_page.dart';

import '../../pages/authentication_page/login_signup_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15.0
                      )
                    ]
                  ),
                  accountName: const Text("Vinay", style: TextStyle(fontWeight: FontWeight.bold),), 
                  accountEmail: const Text("@vinay"),
                  currentAccountPicture: ClipOval(child: Image.asset('lib/assets/profile.png')),
                )
            ),
             onTap: () {
                Get.to(MyProfile());
              },
              ),
            Container(
              height: MediaQuery.of(context).size.height/1.4,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Get.to(MySetting());
              },
            ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log Out'),
                  onTap: () {
                
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('SignIn / SignOut'),
                  onTap: () {
                    Get.to(MyAuthentication());
                  },
                ),
                    ],
                  ),
                ),

                //this is log out button

                //this is footer
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("lib/assets/logo_icon.png", width: 25, height: 25),
                      SizedBox(width: 20),
                      Image.asset("lib/assets/logo.png", width: 150)
                    ],
                  )    
              ],
            ),
            ),
        ],
      ),
    );
  }
}