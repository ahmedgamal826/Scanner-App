import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanner_app/features/home/presentation/views/home_view.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/convert_to_pdf_button.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/show_name_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageToPdfView extends StatefulWidget {
  const ImageToPdfView({super.key});

  @override
  State<ImageToPdfView> createState() => _ImageToPdfViewState();
}

class _ImageToPdfViewState extends State<ImageToPdfView> {
  List<XFile> _selectedImages = [];
  bool _isGenerating = false;
  final ImagePicker picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();

  // Pick images from gallery
  Future<void> pickGalleryImages() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _selectedImages = images;
      });
    }
  }

  // Show dialog to get PDF name from user
  Future<void> _showNameDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return ShowNameDialog(
            onPressed: () {
              String pdfName = _nameController.text.isNotEmpty
                  ? _nameController.text
                  : 'output'; // Default name if empty
              _generatePdf(pdfName);
              Navigator.of(context).pop(); // Close dialog
            },
            nameController: _nameController);
      },
    );
  }

  Future<void> _generatePdf(String pdfName) async {
    if (_selectedImages.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Failed',
        desc: 'Please select images first!',
        descTextStyle: const TextStyle(fontSize: 20),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
        btnOkColor: Colors.red,
        animType: AnimType.scale,
      ).show();
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);

      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> pdfNames = prefs.getStringList('pdf_names') ?? [];

    if (pdfNames.contains(pdfName)) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: 'Failed',
        desc: 'PDF name already exists!',
        descTextStyle: const TextStyle(fontSize: 20),
        animType: AnimType.scale,
      ).show();
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pop(context);

      return;
    }

    setState(() {
      _isGenerating = true;
    });

    final pdf = pw.Document();

    for (var image in _selectedImages) {
      final imageBytes = await image.readAsBytes();
      final pdfImage = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: pw.Image(pdfImage),
          ),
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$pdfName.pdf");
    await file.writeAsBytes(await pdf.save());

    List<String> pdfPaths = prefs.getStringList('pdf_paths') ?? [];
    pdfPaths.add(file.path);
    pdfNames.add(pdfName);

    await prefs.setStringList('pdf_paths', pdfPaths);
    await prefs.setStringList('pdf_names', pdfNames);

    setState(() {
      _isGenerating = false;
    });

    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: 'Success',
      desc: 'PDF saved!',
      descTextStyle: const TextStyle(fontSize: 20),
      btnOkOnPress: () {},
      btnOkColor: Colors.green,
      animType: AnimType.scale,
    ).show();

    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pop();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Images To Pdf',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _selectedImages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/no_image.png',
                          color: Colors.orange,
                          width: width * 0.45,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'No images selected',
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: _selectedImages.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(_selectedImages[index].path),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
          // Displaying the progress indicator in the center of the screen
          _isGenerating
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(100),
                    child: LinearProgressIndicator(
                      color: Colors.orange,
                      minHeight: 10,
                    ),
                  ),
                )
              : _selectedImages.isNotEmpty
                  ? ConvertToPdfButton(
                      onPressed: _showNameDialog,
                    )
                  : const SizedBox.shrink(),
          const SizedBox(height: 5),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: pickGalleryImages,
            backgroundColor: Colors.orange,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
