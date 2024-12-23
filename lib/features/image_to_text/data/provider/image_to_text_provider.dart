import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ImageToTextProvider with ChangeNotifier {
  String _extractedText = '';
  bool _isProcessing = false;
  File? _selectedImage;

  String get extractedText => _extractedText;
  bool get isProcessing => _isProcessing;
  File? get selectedImage => _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      _extractedText = '';
      _isProcessing = true;
      notifyListeners();

      await processImage(_selectedImage!);
    }
  }

  Future<void> processImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      _extractedText = recognizedText.text;
    } catch (e) {
      _extractedText = 'Error: $e';
    } finally {
      _isProcessing = false;
      textRecognizer.close();
      notifyListeners();
    }
  }

  void clearData() {
    _selectedImage = null;
    _extractedText = '';
    notifyListeners();
  }
}
