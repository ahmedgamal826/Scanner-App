import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart'; // استيراد مكتبة المشاركة

class PdfViewerPage extends StatefulWidget {
  final String path;
  final String pdfName;

  const PdfViewerPage({
    super.key,
    required this.path,
    required this.pdfName,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  int _currentPage = 0;
  int _totalPages = 0;
  late PDFViewController _pdfViewController;

  void _sharePdf() {
    Share.shareXFiles(
      [XFile(widget.path)], // Use XFile to reference the file
      text: 'Check out this PDF!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        title: Text(
          '${widget.pdfName}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _sharePdf,
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            fitPolicy: FitPolicy.WIDTH, // عرض الصفحة بالكامل
            onRender: (pages) {
              setState(() {
                _totalPages = pages ?? 0; // تحديث عدد الصفحات
              });
            },
            onViewCreated: (controller) {
              _pdfViewController = controller; // حفظ التحكم في الـ PDF
            },
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page ?? 0; // تحديث الصفحة الحالية
              });
            },
          ),
          Positioned(
            bottom: 20, // تحديد المسافة من الأسفل
            left: MediaQuery.of(context).size.width / 2 -
                50, // توسيط المربع في أسفل الشاشة
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Page ${_currentPage + 1} of $_totalPages',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
