import 'package:flutter/material.dart';
import 'dart:io';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:scanner_app/features/saved_pdfs/presentation/views/widgets/custom_delete_dialog.dart';
import 'package:scanner_app/features/saved_pdfs/presentation/views/widgets/no_pdfs_found_widget.dart';
import 'package:scanner_app/features/saved_pdfs/presentation/views/widgets/pdf_viewer_page_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class PdfListPage extends StatefulWidget {
  const PdfListPage({super.key});

  @override
  State<PdfListPage> createState() => _PdfListPageState();
}

class _PdfListPageState extends State<PdfListPage> {
  List<String> _pdfPaths = [];
  List<String> _pdfNames = [];

  Future<void> _loadPdfPaths() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pdfPaths = prefs.getStringList('pdf_paths') ?? [];
      _pdfNames = prefs.getStringList('pdf_names') ?? [];
    });
  }

  Future<void> _deletePdf(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _pdfPaths.removeAt(index);
      _pdfNames.removeAt(index);
    });
    await prefs.setStringList('pdf_paths', _pdfPaths);
    await prefs.setStringList('pdf_names', _pdfNames);
  }

  void _showDeleteDialog(BuildContext context, int index) {
    showCustomDeleteDialog(
      context: context,
      onConfirm: () async {
        await _deletePdf(index);
        CustomSnackBar.showSuccessSnackBar(
          context,
          'PDF deleted successfully',
        );
      },
    );
  }

  void _sharePdf(String path) {
    Share.shareXFiles(
      [XFile(path)],
      text: 'Check out this PDF!',
    );
  }

  String _getFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes Bytes';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(2)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
    }
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
        title: const Text(
          'Saved PDF Files',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: _pdfPaths.isEmpty
          ? const NoPdfsFoundWidget()
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: _pdfPaths.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfViewerPageWidget(
                            path: _pdfPaths[index],
                            pdfName: _pdfNames[index],
                          ),
                        ),
                      );
                    },
                    child: GridTile(
                      footer: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.orange,
                                size: 25,
                              ),
                              onPressed: () => _sharePdf(_pdfPaths[index]),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ),
                              onPressed: () =>
                                  _showDeleteDialog(context, index),
                            ),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // أيقونة PDF
                          const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.orange,
                            size: 70,
                          ),
                          const SizedBox(height: 10),
                          // اسم الملف
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '${_pdfNames[index]}.pdf',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5),
                          File(_pdfPaths[index]).existsSync()
                              ? Text(
                                  _getFileSize(
                                      File(_pdfPaths[index]).lengthSync()),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                  ),
                                )
                              : const Text(
                                  'File not found',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
