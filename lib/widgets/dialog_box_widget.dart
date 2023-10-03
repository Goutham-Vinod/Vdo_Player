import 'package:flutter/material.dart';

Future dialogBoxWidget(
  context,
  String title,
  String content,
  String buttonText,
  Function onPressFunction,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text(buttonText),
            onPressed: () {
              onPressFunction();
            },
          ),
        ],
      );
    },
  );
}
