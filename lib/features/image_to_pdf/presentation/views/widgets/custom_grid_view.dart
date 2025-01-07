import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanner_app/features/image_to_pdf/data/logic/image_to_pdf_logic.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required ImageToPdfLogic logic,
  }) : _logic = logic;

  final ImageToPdfLogic _logic;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: _logic.selectedImages.length,
      itemBuilder: (context, index) {
        return Image.file(
          File(_logic.selectedImages[index].path),
          fit: BoxFit.cover,
        );
      },
    );
  }
}
