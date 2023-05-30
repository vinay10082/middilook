import 'package:flutter/material.dart';

class MyScrollingText extends StatefulWidget {
  const MyScrollingText({super.key, required this.text, required this.textStyle});

  final text;
  final textStyle;

  @override
  State<MyScrollingText> createState() => _MyScrollingTextState();
}

class _MyScrollingTextState extends State<MyScrollingText> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(widget.text, style: widget.textStyle)
      // Row(
      //   children: [
      // Text(widget.text, style: widget.textStyle),
      // ]
      // ),
    );
    // Text(widget.text, style: widget.textStyle);
  }
}