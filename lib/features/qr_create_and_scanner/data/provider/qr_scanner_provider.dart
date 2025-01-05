import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRCodeScannerProvider extends ChangeNotifier {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrData = "The code has not been scanned yet";
  bool showQRImage = false;
  QRViewController? qrViewController;

  String? scannedCode;
  Timer? resetTimer;
  bool isFlashOn = false;

  File? selectedImage;

  bool showAnimatedBlueLine = true;

  void initializeQRView(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) async {
      resetTimer?.cancel();
      qrData = scanData.code ?? 'QR not defined';
      showQRImage = true;

      if (scanData.code != null) {
        scannedCode = scanData.code!;
        showAnimatedBlueLine = false;
      }

      await HapticFeedback.vibrate();
      notifyListeners();

      resetTimer = Timer(const Duration(seconds: 3), () {
        qrData = 'The code has not been scanned yet';
        showQRImage = false;
        scannedCode = null;
        showAnimatedBlueLine = true;
        notifyListeners();
      });
    });
  }

  Future<void> toggleFlash() async {
    if (qrViewController != null) {
      isFlashOn = !isFlashOn;
      await qrViewController!.toggleFlash();
      notifyListeners();
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (isFlashOn) {
        await toggleFlash();
      }

      selectedImage = File(image.path);

      try {
        final inputImage = InputImage.fromFilePath(image.path);
        final barcodeScanner = BarcodeScanner();

        final barcodes = await barcodeScanner.processImage(inputImage);

        if (barcodes.isNotEmpty) {
          final barcode = barcodes.first;
          qrData = barcode.rawValue ?? "No data found in QR code.";
          showQRImage = true;
        } else {
          qrData = "No QR code found in the image.";
          showQRImage = false;
        }

        barcodeScanner.close();
      } catch (e) {
        qrData = "Error decoding QR code: $e";
        showQRImage = false;
      }

      showAnimatedBlueLine = false;

      resetTimer = Timer(const Duration(seconds: 5), () {
        showQRImage = false;
        scannedCode = null;
        selectedImage = null;
        qrData = 'The code has not been scanned yet';
        showAnimatedBlueLine = true;
        notifyListeners();
      });

      notifyListeners();
    }
  }

  void disposeResources() {
    qrViewController?.dispose();
    resetTimer?.cancel();
  }
}
