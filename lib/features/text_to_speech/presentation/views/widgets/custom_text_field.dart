import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.textDirection,
  });
  final TextEditingController? controller;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Write something...',
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
            width: 3,
          ),
        ),
      ),
      maxLines: 3,
      textDirection: textDirection,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please write something';
        }
        return null;
      },
    );
  }
}
