import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String alertTitle;
  final String? alertContent;
  final String alertAction;
  final void Function()? actionFunction;

  const AlertDialogBox({
    super.key,
    required this.alertTitle,
    this.alertContent,
    required this.alertAction,
    this.actionFunction,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
        children: [
          Text(alertContent!),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: const Text('No', style: TextStyle(color: Colors.white),)
        ),
        TextButton(
          onPressed: actionFunction, 
          child: Text(alertAction, style: const TextStyle(color: Colors.pink),)
        ),
      ],
    );
  }
}