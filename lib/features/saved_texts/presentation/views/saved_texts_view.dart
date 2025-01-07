import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanner_app/core/widgets/custom_snack_bar.dart';
import 'package:scanner_app/features/saved_texts/presentation/views/text_details_view.dart';
import 'package:scanner_app/features/saved_texts/presentation/views/widgets/empty_saved_files_widget.dart';
import 'package:scanner_app/features/saved_texts/presentation/views/widgets/text_card.dart';
import 'package:share_plus/share_plus.dart';

class SavedTextsPage extends StatefulWidget {
  const SavedTextsPage({Key? key}) : super(key: key);

  @override
  _SavedTextsPageState createState() => _SavedTextsPageState();
}

class _SavedTextsPageState extends State<SavedTextsPage> {
  List<FileSystemEntity> _textFiles = [];

  Future<void> _loadSavedTextFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = Directory(directory.path).listSync();

    setState(() {
      _textFiles = files.where((file) => file.path.endsWith('.txt')).toList()
        ..sort(
            (a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedTextFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Saved Text Files',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _textFiles.isEmpty
                ? const EmptySavedFilesWidget()
                : Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _textFiles.length,
                      itemBuilder: (context, index) {
                        String fileName =
                            _textFiles[index].path.split('/').last;

                        return TextCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TextDetailPage(
                                    filePath: _textFiles[index].path),
                              ),
                            );
                          },
                          deleteFun: () async {
                            String filePath = _textFiles[index].path;
                            XFile file = XFile(filePath);
                            await Share.shareXFiles([file],
                                text: 'Check out this file!');
                          },
                          btnOkOnPress: () async {
                            await _textFiles[index].delete();
                            _loadSavedTextFiles();
                            CustomSnackBar.showSuccessSnackBar(
                              context,
                              'Text File deleted successfully!',
                            );
                          },
                          fileName: fileName,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
