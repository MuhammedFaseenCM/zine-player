import 'package:flutter/material.dart';

Future<void> snackBar(
    {required BuildContext context, required content, required bgcolor}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: bgcolor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  ));
}
