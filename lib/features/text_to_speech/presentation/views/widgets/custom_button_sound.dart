import 'package:flutter/material.dart';

class CustomButtonSound extends StatelessWidget {
  CustomButtonSound({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  void Function()? onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 25,
      ),
      label: Text(
        btnText,
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
