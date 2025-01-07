import 'package:flutter/material.dart';

class EmptyImagesWidget extends StatelessWidget {
  const EmptyImagesWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no_image.png',
            color: Colors.orange,
            width: width * 0.45,
          ),
          const SizedBox(height: 20),
          const Text(
            'No images selected',
            style: TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
