import 'package:flutter/material.dart';

showSnackBar(context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: const Color.fromARGB(255, 95, 24, 108),
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
  ));
}
