import 'package:flutter/material.dart';
import 'package:scanner_app/features/home/presentation/views/home_view.dart';

class SplashLogic {
  static Future<void> NavigateToChatHomeView(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false,
    );
  }
}
