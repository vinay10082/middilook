import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final IconData? iconData;
  final String? assetRefrence; //means can be or cannot be required
  final String lableString; //compulsarily required
  final bool isObscure;
  final int? limit;

  const InputTextWidget(
      {super.key, required this.textEditingController,
      this.iconData,
      this.assetRefrence,
      required this.lableString,
      required this.isObscure,
      this.limit});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
            controller: textEditingController,
            inputFormatters: 
            [
            LengthLimitingTextInputFormatter(limit),
            ],
            decoration: InputDecoration(
              //label section
              labelText: lableString,
              floatingLabelStyle: const TextStyle(color: Colors.pink),
              labelStyle: const TextStyle(
                fontSize: 18,
              ),

              //prefixicon section
              prefixIcon: iconData != null
                  ? Icon(iconData)
                  : Padding(
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        assetRefrence!,
                        width: 10,
                      ),
                    ),

              //border section
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink)),
            )));
  }
}
