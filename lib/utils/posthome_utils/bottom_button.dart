import 'package:flutter/material.dart';

import '../../pages/user_upload_pages/upload_page_1.dart';

class BottomButton extends StatelessWidget {
  
  final bottomicon;

  const BottomButton({super.key, this.bottomicon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
              icon: Icon(bottomicon),
              iconSize: 50,
              color: Colors.white, 
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserUpload()));
               },
          
        );
  }

}