import 'package:flutter/material.dart';

class ImageToTextView extends StatelessWidget {
  const ImageToTextView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image To Text',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
