import 'package:flutter/material.dart';
import 'package:scanner_app/features/image_to_pdf/data/logic/image_to_pdf_logic.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/convert_to_pdf_button.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/custom_floating_action_button.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/custom_grid_view.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/custom_linear_progress_indicator.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/empty_image_widget.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/widgets/show_name_dialog.dart';
import 'package:scanner_app/features/home/presentation/views/home_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ImageToPdfView extends StatefulWidget {
  const ImageToPdfView({super.key});

  @override
  State<ImageToPdfView> createState() => _ImageToPdfViewState();
}

class _ImageToPdfViewState extends State<ImageToPdfView> {
  final TextEditingController _nameController = TextEditingController();
  final ImageToPdfLogic _logic = ImageToPdfLogic();

  Future<void> _showNameDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return ShowNameDialog(
          onPressed: () {
            String pdfName = _nameController.text.isNotEmpty
                ? _nameController.text
                : ''; // Assign empty string if name is empty

            if (pdfName.isEmpty) {
              // Show error if name is empty
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                title: 'Error',
                desc: 'Please enter a name for the PDF.',
                descTextStyle: const TextStyle(fontSize: 20),
                animType: AnimType.scale,
              ).show();
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            } else {
              // Proceed if name is valid
              _logic.generatePdf(pdfName, _onSuccess, _onError);
              Navigator.of(context).pop(); // Close dialog
            }
          },
          nameController: _nameController,
        );
      },
    );
  }

  void _onSuccess() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      title: 'Success',
      desc: 'PDF saved!',
      descTextStyle: const TextStyle(fontSize: 20),
      animType: AnimType.scale,
    ).show();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  void _onError(String message) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      title: 'Failed',
      desc: message,
      descTextStyle: const TextStyle(fontSize: 20),
      animType: AnimType.scale,
    ).show();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
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
            child: _logic.selectedImages.isEmpty
                ? EmptyImagesWidget(width: width)
                : CustomGridView(logic: _logic),
          ),
          // Displaying the progress indicator in the center of the screen
          _logic.isGenerating
              ? CustomLinearProgressIndicator(width: width)
              : _logic.selectedImages.isNotEmpty
                  ? ConvertToPdfButton(
                      onPressed: _showNameDialog,
                    )
                  : const SizedBox.shrink(),
          const SizedBox(height: 5),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          await _logic.pickGalleryImages();
          setState(() {});
        },
      ),
    );
  }
}
