import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/widgets/show_snack_bar.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String qrData = "The code has not been scanned yet";
  bool showQRImage = false;
  late AnimationController _controller;
  late Animation<double> _animation;
  QRViewController? qrViewController;

  Timer? resetTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 250).animate(_controller);
  }

  // Qr Code Scanner Function
  void _onQRViewCreated(QRViewController controller) {
    qrViewController = controller;

    controller.scannedDataStream.listen((scanData) async {
      resetTimer?.cancel();
      setState(() {
        qrData = scanData.code ?? 'QR not defined';
        showQRImage = true; // after scanning qr ==> show qr image
        _controller.stop(); // stop blue line
      });

      // Enable vibration throurgh scanning
      await HapticFeedback.vibrate();

      resetTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          qrData = 'The code has not been scanned yet';
          showQRImage = false;
          _controller.repeat(); // restart ble line
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    qrViewController?.dispose();
    resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'QR Code Scanner',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: [
          // QR Scanner
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.orange,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 7,
              cutOutSize: width * 0.63,
            ),
          ),
          // Overlay with transparent square and animated blue line
          Center(
            child: Stack(
              children: [
                Container(
                  width: width * 0.63,
                  height: height * 0.30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: showQRImage
                      ? QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: width * 0.63,
                          backgroundColor: Colors.white,
                        )
                      : null,
                ),
                if (!showQRImage)
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          // Display scanned data at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black.withOpacity(0.8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      qrData,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: qrData));

                      customShowSnackBar(
                          context: context, content: 'Link copied!');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
