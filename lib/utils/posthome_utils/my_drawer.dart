import 'package:flutter/material.dart';

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
          Container(
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
            Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      ListTile(
              leading: Icon(Icons.abc),
              title: Text('option 1'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('option 2'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: Icon(Icons.abc),
              title: Text('option 3'),
              onTap: () {
                
              },
            )
                    ],
                  ),
                ),

                //this is footor
                Column(
                  children: <Widget>[
                    Image.asset('lib/assets/logo.png')
                  ],
                ),
              ],
            ),
            ),
        ],
      ),
    );
  }
}