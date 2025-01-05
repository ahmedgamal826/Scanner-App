import 'package:flutter/material.dart';
import 'package:scanner_app/features/home/presentation/views/widgets/build_card.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/PdfListPage.dart';
import 'package:scanner_app/features/image_to_pdf/presentation/views/image_to_pdf_view.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/image_to_text_view.dart';
import 'package:scanner_app/features/qr_create_and_scanner/presentation/views/qr_code_home_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Document Tools',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to Document Tools!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  BuildFeatureCard(
                    icon: Icons.picture_as_pdf,
                    title: 'Image to PDF',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageToPdfView(),
                        ),
                      );
                    },
                  ),
                  BuildFeatureCard(
                    icon: Icons.folder,
                    title: 'Saved PDFs',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PdfListPage(),
                        ),
                      );
                    },
                  ),
                  BuildFeatureCard(
                    icon: Icons.text_snippet,
                    title: 'PDF to Text',
                    onTap: () {
                      // Navigate to PDF to Text page
                    },
                  ),
                  BuildFeatureCard(
                    icon: Icons.image,
                    title: 'Image to Text',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageToTextView(),
                        ),
                      );
                    },
                  ),
                  BuildFeatureCard(
                    icon: Icons.qr_code_scanner,
                    title: 'QR Scanner',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QrCodeHomeView(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
