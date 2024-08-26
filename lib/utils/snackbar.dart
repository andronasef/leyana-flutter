import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    duration: const Duration(seconds: 2),
    content: Text(message),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
