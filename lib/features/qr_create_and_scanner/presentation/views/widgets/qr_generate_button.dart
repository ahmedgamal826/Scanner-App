import 'package:flutter/material.dart';

class QrGenerateButton extends StatelessWidget {
  QrGenerateButton({super.key, required this.onPressed});

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Generate QR Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
