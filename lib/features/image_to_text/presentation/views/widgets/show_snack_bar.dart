import 'package:flutter/material.dart';

void customShowSnackBar({
  required BuildContext context,
  required String content,
}) {
  double height = MediaQuery.of(context).size.height;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          textAlign: TextAlign.center,
          content,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: Colors.blue,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(80),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
