import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/widgets/show_snack_bar.dart';

class ImageToTextView extends StatefulWidget {
  const ImageToTextView({super.key});

  @override
  State<ImageToTextView> createState() => _ImageToTextViewState();
}

class _ImageToTextViewState extends State<ImageToTextView> {
  String _extractedText = '';
  bool _isProcessing = false;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _extractedText = '';
        _isProcessing = true;
      });
      _processImage(_selectedImage!);
    }
  }

  Future<void> _processImage(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();

    try {
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      setState(() {
        _extractedText = recognizedText.text;
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _extractedText = 'Error: $e';
      });
    } finally {
      textRecognizer.close();
    }
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    customShowSnackBar(
      context: context,
      content: 'Text copied to clipboard!',
    );
  }

  void _clearData() {
    setState(() {
      _selectedImage = null;
      _extractedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/back.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.47,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/note.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Stack(
                    alignment: _extractedText == ''
                        ? Alignment.center
                        : Alignment.topLeft,
                    children: [
                      if (_isProcessing)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 50),
                          child: SingleChildScrollView(
                            child: Text(
                              _extractedText.isEmpty
                                  ? 'No text extracted yet'
                                  : _extractedText,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      if (_extractedText.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_extractedText.isNotEmpty ||
                                      _selectedImage != null) {
                                    _clearData();
                                  }
                                },
                                icon: const Icon(
                                  Icons.cancel_presentation_outlined,
                                  size: 27,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.copy,
                                    color: Colors.orange),
                                onPressed: () =>
                                    _copyToClipboard(_extractedText),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _showImageSourceDialog,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/pin.png',
                        width: MediaQuery.of(context).size.width * 0.70,
                        height: MediaQuery.of(context).size.height * 0.40,
                        fit: BoxFit.cover,
                      ),
                      ClipRRect(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.34,
                          width: MediaQuery.of(context).size.width * 0.61,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: _selectedImage == null
                                ? Colors.white
                                : Colors.transparent,
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.fill,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? const Icon(
                                  Icons.image_search,
                                  size: 50,
                                  color: Colors.black,
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
