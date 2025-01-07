import 'dart:convert';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard/whiteboard.dart';
import 'dart:ui' as ui;

class WhiteboardProvider with ChangeNotifier {
  Color? selectedColor; // لا يتم تعيين لون افتراضي بعد
  double selectedStrokeWidth = 5.0;
  final WhiteBoardController _controller = WhiteBoardController();
  bool isErasing = false;
  List<Map<String, dynamic>> savedImages = [];
  bool isBoardModified =
      false; // Track whether the board has been modified or not

  WhiteBoardController get controller => _controller;

  WhiteboardProvider() {
    loadSavedImages(); // Load saved images when provider is created
    _controller.addListener(_onBoardChanged); // Add listener to detect changes
  }

  void _onBoardChanged() {
    isBoardModified = true; // Set to true whenever there is a change
    notifyListeners();
  }

  Future<void> loadSavedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedImages = prefs.getStringList('savedImages');
    if (storedImages != null) {
      savedImages = storedImages.map((imageData) {
        Map<String, dynamic> data = json.decode(imageData);
        return {
          'image': data['image'],
          'dateTime': data['dateTime'],
        };
      }).toList();
      notifyListeners(); // Notify listeners when data is loaded
    }
  }

  void undo() {
    _controller.undo();
    notifyListeners();
  }

  void redo() {
    _controller.redo();
    notifyListeners();
  }

  void clearBoard() {
    _controller.clear();
    isBoardModified = true; // Clear also counts as a modification
    notifyListeners();
  }

  void toggleEraser() {
    isErasing = !isErasing;
    isBoardModified = true; // Toggle eraser counts as a modification
    notifyListeners();
  }

  Future<Uint8List> convertImageToBytes(Image image) async {
    final completer = Completer<ui.Image>();
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );

    final uiImage = await completer.future;
    final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> saveImage(BuildContext context) async {
    if (!isBoardModified) return; // Prevent saving if no changes were made

    final imageBytes = await _controller.convertToImage();
    if (imageBytes != null) {
      final currentTime = DateTime.now();
      final savedImage = Image.memory(imageBytes);

      final bytes = await convertImageToBytes(savedImage);
      final base64String = base64Encode(bytes);

      savedImages.add({
        'image': base64String,
        'dateTime': currentTime.toIso8601String(),
      });

      await _saveImagesToPreferences();
      CustomSnackBar.showSuccessSnackBar(
        context,
        'Image saved successfully!',
      );
      isBoardModified = false; // Reset after saving
      notifyListeners();
    }
  }

  Future<void> deleteImage(int index) async {
    savedImages.removeAt(index); // حذف الصورة من الذاكرة
    await _saveImagesToPreferences(); // تحديث SharedPreferences
    notifyListeners(); // تحديث واجهة المستخدم
  }

  Future<void> _saveImagesToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> imagesData = savedImages.map((imageInfo) {
      return json.encode({
        'image': imageInfo['image'],
        'dateTime': imageInfo['dateTime'].toString(),
      });
    }).toList();
    await prefs.setStringList('savedImages', imagesData);
  }

  List<Map<String, dynamic>> getSavedImages() {
    return savedImages;
  }

  void setColor(Color color) {
    if (selectedColor != color) {
      // تحقق إذا كان اللون قد تغير بالفعل
      selectedColor = color;
      isBoardModified = true; // التأكد من تفعيل التعديل إذا تم تغيير اللون
      notifyListeners();
    }
  }

  void setStrokeWidth(double width) {
    selectedStrokeWidth = width;
    isBoardModified = true; // Stroke width change counts as a modification
    notifyListeners();
  }
}
