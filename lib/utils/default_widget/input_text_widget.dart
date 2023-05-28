import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget 
{

  final TextEditingController textEditingController;
  final IconData? iconData;
  final String? assetRefrence; //means can be or cannot be required
  final String  lableString; //compulsarily required
  final bool isObscure;

  InputTextWidget(
    { 
      required this.textEditingController,
      this.iconData,
      this.assetRefrence,
      required this.lableString,
      required this.isObscure

    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        //label section
        labelText: lableString,
        floatingLabelStyle: TextStyle(color: Colors.pink),
        labelStyle: TextStyle(
          fontSize: 18,
        ),

        //prefixicon section
        prefixIcon: iconData != null ? Icon(iconData) 
        : Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(assetRefrence!, width: 10,),
        ),

        //border section
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
    )
      )
    );
  }
}