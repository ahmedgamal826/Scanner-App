import 'package:flutter/material.dart';

class NoPdfsFoundWidget extends StatelessWidget {
  const NoPdfsFoundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Text(
            'No PDFs found',
            style: TextStyle(
              fontSize: 23,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
