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
        controller: nameController,
        decoration: const InputDecoration(
          labelText: 'PDF Name',
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
