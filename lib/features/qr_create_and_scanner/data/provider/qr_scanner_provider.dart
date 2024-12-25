import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRCodeScannerProvider extends ChangeNotifier {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrData = "The code has not been scanned yet";
  bool showQRImage = false;
  QRViewController? qrViewController;

  File? selectedImage;
  Timer? resetTimer;

  bool isFlashOn = false;

  void initializeQRView(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) async {
      resetTimer?.cancel();
      qrData = scanData.code ?? 'QR not defined';
      showQRImage = true;

      await HapticFeedback.vibrate();

      notifyListeners();

      resetTimer = Timer(const Duration(seconds: 3), () {
        qrData = 'The code has not been scanned yet';
        showQRImage = false;

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

      notifyListeners();
    }
  }

  void disposeResources() {
    qrViewController?.dispose();
    resetTimer?.cancel();
  }
}
