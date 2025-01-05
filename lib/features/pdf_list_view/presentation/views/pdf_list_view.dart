import 'package:flutter/material.dart';

class PdfListView extends StatelessWidget {
  const PdfListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Saved Pdfs',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Saved PDF',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
