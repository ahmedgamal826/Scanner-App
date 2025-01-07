import 'package:flutter/material.dart';

class SaveTextButton extends StatelessWidget {
  SaveTextButton({super.key, required this.onPressed});

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        backgroundColor: Colors.orange,
      ),
      child: const Text(
        'Save as .txt',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}
