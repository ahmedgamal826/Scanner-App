import 'package:flutter/material.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/image_to_text_view.dart';

class SplashLogic {
  static Future<void> NavigateToChatHomeView(BuildContext context) async {
    try {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ImageToTextView()),
        (route) => false,
      );
    } catch (e) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const ImageToTextView()),
        (route) => false,
      );
    }
  }
}
