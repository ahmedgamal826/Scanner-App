import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:scanner_app/features/write_page/presentation/views/widgets/custom_text_form_field.dart';
import 'package:scanner_app/features/write_page/presentation/views/widgets/dialog_buttons.dart';
import 'package:scanner_app/features/write_page/presentation/views/widgets/dialog_text_field.dart';
import 'package:scanner_app/features/write_page/presentation/views/widgets/save_text_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _textFormKey = GlobalKey<FormState>();

  Future<bool> _isFileNameExists(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();
    return files.any((file) => file.path.split('/').last == '$fileName.txt');
  }

  Future<void> _saveToFile(String fileName) async {
    if (await _isFileNameExists(fileName)) {
      CustomSnackBar.showErrorSnackBar(
        context,
        'File name already exists',
      );
      return; // stop save file if file name already exist
    }

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.txt');

    await file.writeAsString(_controller.text);

    // Save the current date and time in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String timestamp = DateTime.now().toString();
    await prefs.setString(fileName, timestamp);

    CustomSnackBar.showSuccessSnackBar(
      context,
      'File saved as $fileName.txt',
    );
  }

  Future<void> _showFileNameDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Enter File Name',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            key: _formKey,
            child: DialogTextField(
              fileNameController: _fileNameController,
            ),
          ),
          actions: [
            DialogButtons(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _saveToFile(_fileNameController.text);
                  _fileNameController.clear();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Write Text',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _textFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(controller: _controller),
              const SizedBox(height: 20),
              SaveTextButton(
                onPressed: () {
                  if (_textFormKey.currentState!.validate()) {
                    _showFileNameDialog();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
