import 'package:flutter/material.dart';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/pdf_viewer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class PdfListPage extends StatefulWidget {
  const PdfListPage({super.key});

  @override
  State<PdfListPage> createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  List<String> _pdfPaths = [];
  List<String> _pdfNames = [];

  /// Load PDF paths and names from SharedPreferences
  Future<void> _loadPdfPaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pdfPaths = prefs.getStringList('pdf_paths') ?? [];
      _pdfNames = prefs.getStringList('pdf_names') ?? [];
    });
  }

  /// Delete a PDF file
  Future<void> _deletePdf(int index) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove the path and name from the list
    setState(() {
      _pdfPaths.removeAt(index);
      _pdfNames.removeAt(index);
    });

    // Save the updates in SharedPreferences
    await prefs.setStringList('pdf_paths', _pdfPaths);
    await prefs.setStringList('pdf_names', _pdfNames);
  }

  /// Show confirmation dialog for deletion
  void _showDeleteDialog(BuildContext context, int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.topSlide,
      title: 'Confirm Delete',
      desc: 'Are you sure you want to delete this PDF?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await _deletePdf(index);
        CustomSnackBar.showSuccessSnackBar(
          context,
          'PDF deleted successfully',
        );
      },
      titleTextStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(fontSize: 18),
      btnOkColor: Colors.red,
      btnCancelColor: Colors.grey,
    ).show();
  }

  /// Share a PDF file
  void _sharePdf(String path) {
    Share.shareXFiles(
      [XFile(path)],
      text: 'Check out this PDF!',
    );
  }

  @override
  void initState() {
    super.initState();
    _loadPdfPaths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Saved PDF Files',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: _pdfPaths.isEmpty
          ? const Center(child: Text('No PDFs found'))
          : ListView.builder(
              itemCount: _pdfPaths.length,
              itemBuilder: (context, index) {
                double height = MediaQuery.of(context).size.height;
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10,
                  ),
                  child: Container(
                    height: height * 0.11,
                    child: ListTile(
                      leading: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.orange,
                        size: 40,
                      ),
                      title: Text(
                        _pdfNames.isNotEmpty
                            ? '${_pdfNames[index]}.pdf'
                            : 'PDF ${index + 1}.pdf',
                        style: const TextStyle(fontSize: 17),
                      ),
                      subtitle: Text(
                          '${File(_pdfPaths[index]).lengthSync() ~/ 1024} Kb'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.orange),
                            onPressed: () {
                              _sharePdf(_pdfPaths[index]);
                            },
                          ),
                          IconButton(
                            icon:
                                const Icon(Icons.delete, color: Colors.orange),
                            onPressed: () {
                              _showDeleteDialog(context, index);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PdfViewerPage(
                                path: _pdfPaths[index],
                                pdfName: _pdfNames[index]),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
