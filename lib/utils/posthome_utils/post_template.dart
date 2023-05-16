import 'package:flutter/material.dart';
import 'package:middilook/utils/posthome_utils/right_button.dart';

class PostTemplate extends StatelessWidget {

  final String username;
  final String description;
  final String link;
  final userPost;
  
  const PostTemplate({required this.username, required this.description, required this.link, required this.userPost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //user post at very back
          userPost,

          //username and caption
          Padding(padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 100.0),
          child: Container(
            alignment: Alignment(-1, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('@'+ username,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
                SizedBox(
                  height: 10,
                ),
                RichText(text: TextSpan(
                  children: [
                    TextSpan(text: description, style: TextStyle(color: Colors.white)),
                    TextSpan(text: '#flutter', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ]
                   ))
              ]),
            ),
          ),

          //buttons
          Padding(padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 100.0),
          child: Container(alignment: Alignment(1,1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
              icon: Icons.link,
              text: '201',
              ),
              MyButton(
              icon: Icons.send_outlined,
              text: 'Share',
              ),

            ],
            ),
          ),
        ),
      ],
    )
  );
  }
}