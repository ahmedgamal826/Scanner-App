import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:scanner_app/features/pdf_to_text/data/provider/pdf_to_text_provider.dart';

class PdfToTextView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdfProvider = Provider.of<PdfProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        pdfProvider.clearData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text(
            'PDF to Text',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (pdfProvider.isLoading)
                Column(
                  children: [
                    const Text(
                      'Loading File...',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: pdfProvider.progress,
                      backgroundColor: Colors.grey[200],
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange, width: 3),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[50],
                  ),
                  child: pdfProvider.extractedText != null
                      ? Scrollbar(
                          child: SingleChildScrollView(
                            child: SelectableText(
                              pdfProvider.extractedText!,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            'No text extracted yet. Choose a PDF to start.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => pdfProvider.choosePDF(context),
                    icon: const Icon(Icons.attach_file, color: Colors.white),
                    label: const Text(
                      'Choose PDF',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: pdfProvider.filePath != null
                        ? () => OpenFile.open(pdfProvider.filePath)
                        : null,
                    icon: const Icon(Icons.open_in_new, color: Colors.white),
                    label: const Text(
                      'Open PDF',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      disabledBackgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
