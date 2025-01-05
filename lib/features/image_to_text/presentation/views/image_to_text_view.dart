import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/image_to_text/data/provider/image_to_text_provider.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/widgets/show_snack_bar.dart';

class ImageToTextView extends StatelessWidget {
  const ImageToTextView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageToTextProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text(
          'Image to Text',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
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
              const SizedBox(height: 10),
              _buildResultCard(provider, context),
              const SizedBox(height: 20),
              _buildImagePicker(provider, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(ImageToTextProvider provider, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.44,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/note.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange),
      ),
      child: Stack(
        alignment: provider.extractedText.isEmpty
            ? Alignment.center
            : Alignment.topLeft,
        children: [
          if (provider.isProcessing)
            const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            )
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: SingleChildScrollView(
                child: Text(
                  provider.extractedText.isEmpty
                      ? 'No text extracted yet'
                      : provider.extractedText,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          if (provider.extractedText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: provider.clearData,
                    icon: const Icon(
                      Icons.cancel_presentation_outlined,
                      size: 27,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.orange),
                    onPressed: () => Clipboard.setData(
                      ClipboardData(text: provider.extractedText),
                    ).then(
                      (_) {
                        customShowSnackBar(
                          context: context,
                          content: 'Text copied to clipboard!',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImagePicker(ImageToTextProvider provider, BuildContext context) {
    return GestureDetector(
      onTap: () => _showImageSourceDialog(provider, context),
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
                color: provider.selectedImage == null
                    ? Colors.white
                    : Colors.transparent,
                image: provider.selectedImage != null
                    ? DecorationImage(
                        image: FileImage(provider.selectedImage!),
                        fit: BoxFit.fill,
                      )
                    : null,
              ),
              child: provider.selectedImage == null
                  ? const Icon(
                      Icons.image_search,
                      size: 60,
                      color: Colors.black,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showImageSourceDialog(
      ImageToTextProvider provider, BuildContext context) async {
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
                provider.pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                provider.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
