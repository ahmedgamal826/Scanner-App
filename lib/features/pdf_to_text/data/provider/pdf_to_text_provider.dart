import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfProvider extends ChangeNotifier {
  PdfDocument? _document;
  String? _filePath;
  String? _extractedText;
  double _progress = 0.0;
  bool _isLoading = false;

  String? get filePath => _filePath;
  String? get extractedText => _extractedText;
  double get progress => _progress;
  bool get isLoading => _isLoading;

  Future<void> choosePDF(BuildContext context) async {
    _isLoading = true;
    _progress = 0.0;
    _extractedText = null;
    notifyListeners();

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      _filePath = result.files.single.path!;
      await _simulateLoadingProgress();

      try {
        _document = PdfDocument(
          inputBytes: await _readDocumentData(_filePath!),
        );
        _extractAllText();
      } catch (e) {
        _isLoading = false;
        notifyListeners();
        _showErrorSnackBar(context, 'Failed to load document.');
      }
    } else {
      _isLoading = false;
      notifyListeners();
      _showErrorSnackBar(context, 'No file selected.');
    }
  }

  Future<void> _simulateLoadingProgress() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20), () {
        _progress = i / 100;
        notifyListeners();
      });
    }
  }

  Future<void> _extractAllText() async {
    if (_document != null) {
      PdfTextExtractor extractor = PdfTextExtractor(_document!);
      _extractedText = extractor.extractText();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<List<int>> _readDocumentData(String filePath) async {
    final File file = File(filePath);
    return await file.readAsBytes();
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    CustomSnackBar.showErrorSnackBar(context, message);
  }

  // Clear data when leaving the page
  void clearData() {
    _document?.dispose();
    _filePath = null;
    _extractedText = null;
    _progress = 0.0;
    _isLoading = false;
    notifyListeners();
  }
}
