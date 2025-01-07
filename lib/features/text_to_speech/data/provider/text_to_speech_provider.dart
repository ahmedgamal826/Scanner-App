import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class TextToSpeechProvider with ChangeNotifier {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textController = TextEditingController();
  final LanguageIdentifier languageIdentifier =
      LanguageIdentifier(confidenceThreshold: 0.5);
  bool isPlaying = false;
  String detectedLanguage = "";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextDirection textDirection = TextDirection.ltr; // Default to left to right

  Future<void> _detectLanguage() async {
    final text = textController.text;
    if (text.isNotEmpty) {
      try {
        detectedLanguage = await languageIdentifier.identifyLanguage(text);
        print("Detected language: $detectedLanguage");
        // Set text direction based on detected language
        if (detectedLanguage == 'ar') {
          // Arabic language
          textDirection = TextDirection.rtl;
        } else {
          textDirection = TextDirection.ltr;
        }
      } catch (e) {
        print("Error detecting language: $e");
      }
    } else {
      detectedLanguage = "unknown";
    }
    notifyListeners(); // Notify listeners when the language is detected
  }

  Future<void> speak() async {
    if (textController.text.isNotEmpty) {
      await _detectLanguage();
      if (detectedLanguage != "unknown") {
        isPlaying = true;
        notifyListeners(); // Notify listeners when speech starts
        await flutterTts.setLanguage(detectedLanguage);
        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);

        // Listen to completion and set isPlaying to false
        flutterTts.setCompletionHandler(() {
          isPlaying = false;
          notifyListeners(); // Update state after speech ends
        });

        await flutterTts.speak(textController.text);
      } else {
        throw Exception('Failed to detect language');
      }
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
    isPlaying = false;
    notifyListeners(); // Notify listeners when speech stops
  }

  @override
  void dispose() {
    textController.dispose();
    languageIdentifier.close();
    super.dispose();
  }
}
