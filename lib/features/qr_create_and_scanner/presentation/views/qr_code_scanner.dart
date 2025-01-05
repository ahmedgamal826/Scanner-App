import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_app/features/qr_create_and_scanner/data/provider/qr_scanner_provider.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/animated_blue_line.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/bottom_scan_data_container.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/flash_and_image_container.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 250).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    context.read<QRCodeScannerProvider>().disposeResources();
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
      body: ChangeNotifierProvider(
        create: (_) => QRCodeScannerProvider(),
        child: Consumer<QRCodeScannerProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                QRView(
                  key: provider.qrKey,
                  onQRViewCreated: provider.initializeQRView,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.orange,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 7,
                    cutOutSize: width * 0.63,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: width * 0.63,
                            height: height * 0.30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            child: provider.showQRImage &&
                                    provider.scannedCode != null
                                ? QrImageView(
                                    data: provider.scannedCode!,
                                    version: QrVersions.auto,
                                    size: 200.0,
                                    backgroundColor: Colors.white,
                                  )
                                : provider.selectedImage != null
                                    ? Image.file(provider.selectedImage!)
                                    : null,
                          ),
                          if (provider.showAnimatedBlueLine)
                            AnimatedBlueLine(animation: _animation),
                        ],
                      ),
                    ],
                  ),
                ),
                FlashAndImageContainer(
                  width: width,
                  flashColor: provider.isFlashOn ? Colors.yellow : Colors.white,
                  flashOnPressed: provider.toggleFlash,
                  imageOnPressed: () => provider.pickImageFromGallery(context),
                ),
                BottomScanDataContainer(
                  qrData: provider.qrData.isNotEmpty
                      ? provider.qrData
                      : "No data scanned",
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
