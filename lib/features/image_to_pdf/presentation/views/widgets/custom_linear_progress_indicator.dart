import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(width * 0.25),
        child: LinearProgressIndicator(
          color: Colors.orange,
          minHeight: 10,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
