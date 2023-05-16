import 'package:flutter/material.dart';

import '../utils/posthome_utils/post_template.dart';

class Post1 extends StatelessWidget {
  const Post1({super.key});

  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      username: 'vinay',
      description: 'review of the day',
      link: '#',
      userPost: Container(
        color: Colors.amber.shade300,
      )
    );
  }
}