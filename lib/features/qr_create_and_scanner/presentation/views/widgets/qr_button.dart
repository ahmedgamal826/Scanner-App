import 'package:flutter/material.dart';

class QrButton extends StatefulWidget {
  QrButton({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  void Function()? onPressed;
  String btnText;

  @override
  State<QrButton> createState() => _QrButtonState();
}

class _QrButtonState extends State<QrButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.btnText == 'Create QR Code'
                ? Icons.create
                : Icons.qr_code_scanner,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            widget.btnText,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.btnText == 'Create QR Code' ? 19 : 20,
            ),
          ),
        ],
      ),
    );
  }
}
