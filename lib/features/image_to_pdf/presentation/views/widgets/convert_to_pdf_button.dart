import 'package:flutter/material.dart';

class ConvertToPdfButton extends StatelessWidget {
  ConvertToPdfButton({super.key, required this.onPressed});

  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        onPressed: onPressed, // Show the dialog
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(double.infinity, width * 0.13),
        ),
        child: const Text(
          'Convert Images to PDF',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
