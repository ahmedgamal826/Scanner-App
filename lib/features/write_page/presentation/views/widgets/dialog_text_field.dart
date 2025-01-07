import 'package:flutter/material.dart';

class DialogTextField extends StatelessWidget {
  const DialogTextField({
    super.key,
    required TextEditingController fileNameController,
  }) : _fileNameController = fileNameController;

  final TextEditingController _fileNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.orange,
      controller: _fileNameController,
      decoration: const InputDecoration(
        hintText: 'Enter file name',
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 3,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'File name cannot be empty';
        }
        return null; // If validation passes
      },
    );
  }
}
