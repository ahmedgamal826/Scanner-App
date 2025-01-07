import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.orange,
      controller: _controller,
      maxLines: 10,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Start writing here...',
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 3,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text to save';
        }
        return null; // If validation passes
      },
    );
  }
}
