import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/qr_generate_button.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/widgets/qr_text_field.dart';

class QrCodeCreate extends StatefulWidget {
  @override
  _QrCodeCreateState createState() => _QrCodeCreateState();
}

class _QrCodeCreateState extends State<QrCodeCreate> {
  final TextEditingController _textController = TextEditingController();
  String _qrData = '';

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Create QR Code',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              QrCreateTextField(textController: _textController),
              const SizedBox(height: 16),
              QrGenerateButton(onPressed: () {
                setState(() {
                  _qrData = _textController.text;
                });
              }),
              const SizedBox(height: 16),
              if (_qrData.isNotEmpty)
                QrImageView(
                  data: _qrData,
                  version: QrVersions
                      .auto, // كلما زادت البيانات المراد ترميزها، زادت تعقيد نسخة رمز QR
                  size: 200.0,
                  backgroundColor: Colors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
