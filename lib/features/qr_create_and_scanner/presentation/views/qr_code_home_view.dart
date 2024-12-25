import 'package:flutter/material.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/qr_code_create.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/qr_code_scanner.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/qr_button.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/qr_home_app_bar.dart';

class QrCodeHomeView extends StatefulWidget {
  @override
  _QrCodeHomeViewState createState() => _QrCodeHomeViewState();
}

class _QrCodeHomeViewState extends State<QrCodeHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QrHomeAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Choose an option',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              QrButton(
                btnText: 'Create QR Code',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QrCodeCreate(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              QrButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QRCodeScanner(),
                    ),
                  );
                },
                btnText: 'Scan QR Code',
              )
            ],
          ),
        ),
      ),
    );
  }
}
