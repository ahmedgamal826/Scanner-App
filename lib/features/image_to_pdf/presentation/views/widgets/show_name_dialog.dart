import 'package:flutter/material.dart';

class ShowNameDialog extends StatelessWidget {
  ShowNameDialog({
    super.key,
    required this.onPressed,
    required this.nameController,
  });

  void Function()? onPressed;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter PDF Name'),
      content: TextField(
        cursorColor: Colors.orange,
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          labelText: 'PDF Name',
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 17,
              color: Colors.orange,
            ),
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Generate PDF',
            style: TextStyle(
              fontSize: 17,
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
