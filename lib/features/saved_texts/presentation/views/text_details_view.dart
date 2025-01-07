// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TextDetailPage extends StatefulWidget {
//   final String filePath;
//   const TextDetailPage({Key? key, required this.filePath}) : super(key: key);

//   @override
//   _TextDetailPageState createState() => _TextDetailPageState();
// }

// class _TextDetailPageState extends State<TextDetailPage> {
//   late TextEditingController _textController;
//   late String fileName;

//   @override
//   void initState() {
//     super.initState();
//     fileName = widget.filePath.split('/').last; // استخراج اسم الملف من المسار
//     _textController = TextEditingController();
//     _loadTextFromFile();
//   }

//   // تحميل النص من الملف
//   Future<void> _loadTextFromFile() async {
//     final file = File(widget.filePath);
//     String text = await file.readAsString();
//     _textController.text = text;
//   }

//   // حفظ النص المعدل
//   Future<void> _saveText() async {
//     final file = File(widget.filePath);
//     await file.writeAsString(_textController.text);

//     // حفظ النص في SharedPreferences
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(widget.filePath.split('/').last, _textController.text);

//     // العودة للصفحة السابقة بعد الحفظ
//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           fileName,
//           style: const TextStyle(
//             fontSize: 22,
//             color: Colors.white,
//             fontStyle: FontStyle.italic,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.orange,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: _saveText,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.orange.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: Colors.orange, width: 2),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _textController,
//               maxLines: null,
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//               ),
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextDetailPage extends StatefulWidget {
  final String filePath;
  const TextDetailPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _TextDetailPageState createState() => _TextDetailPageState();
}

class _TextDetailPageState extends State<TextDetailPage> {
  late TextEditingController _textController;
  late String fileName;

  @override
  void initState() {
    super.initState();
    fileName = widget.filePath.split('/').last; // استخراج اسم الملف من المسار
    _textController = TextEditingController();
    _loadTextFromFile();
  }

  // تحميل النص من الملف
  Future<void> _loadTextFromFile() async {
    final file = File(widget.filePath);
    if (await file.exists()) {
      String text = await file.readAsString();
      _textController.text = text;
    }
  }

  // حفظ النص المعدل
  Future<void> _saveText() async {
    final file = File(widget.filePath);
    await file.writeAsString(_textController.text);

    // حفظ النص في SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(widget.filePath.split('/').last, _textController.text);

    // العودة للصفحة السابقة بعد الحفظ
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          fileName,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveText,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _textController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
