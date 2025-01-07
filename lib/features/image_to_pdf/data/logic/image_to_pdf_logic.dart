import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageToPdfLogic {
  final ImagePicker picker = ImagePicker();
  bool isGenerating = false;

  List<XFile> selectedImages = [];

  // Pick images from gallery
  Future<void> pickGalleryImages() async {
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      selectedImages = images;
    }
  }

  // Generate PDF
  Future<void> generatePdf(
      String pdfName, Function onSuccess, Function onError) async {
    if (selectedImages.isEmpty) {
      onError('Please select images first!');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    List<String> pdfNames = prefs.getStringList('pdf_names') ?? [];

    if (pdfNames.contains(pdfName)) {
      onError('PDF name already exists!');
      return;
    }

    isGenerating = true;

    final pdf = pw.Document();

    for (var image in selectedImages) {
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

    isGenerating = false;

    onSuccess();
  }
}
