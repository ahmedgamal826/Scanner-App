import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showCustomDeleteDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.topSlide,
    title: 'Confirm Delete',
    desc: 'Are you sure you want to delete this PDF?',
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    descTextStyle: const TextStyle(fontSize: 18),
    btnCancelOnPress: () {},
    btnOkOnPress: onConfirm,
    btnOkColor: Colors.red,
    btnCancelColor: Colors.grey,
  ).show();
}
