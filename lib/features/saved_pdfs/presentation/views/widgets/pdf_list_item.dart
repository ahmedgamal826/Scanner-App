// import 'package:flutter/material.dart';
// import 'dart:io';

// class PdfListItem extends StatelessWidget {
//   final String pdfPath;
//   final String pdfName;
//   final VoidCallback onDelete;
//   final VoidCallback onShare;
//   final VoidCallback onTap;

//   const PdfListItem({
//     Key? key,
//     required this.pdfPath,
//     required this.pdfName,
//     required this.onDelete,
//     required this.onShare,
//     required this.onTap,
//   }) : super(key: key);

//   String _getFileSize(int bytes) {
//     if (bytes < 1024) {
//       return '$bytes Bytes';
//     } else if (bytes < 1024 * 1024) {
//       return '${(bytes / 1024).toStringAsFixed(2)} KB';
//     } else if (bytes < 1024 * 1024 * 1024) {
//       return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
//     } else {
//       return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Container(
//       height: height * 0.13,
//       child: Card(
//         elevation: 3,
//         margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
//         child: ListTile(
//           leading: const Icon(
//             Icons.picture_as_pdf,
//             color: Colors.orange,
//             size: 50,
//           ),
//           title: Text(
//             '$pdfName.pdf',
//             style: const TextStyle(fontSize: 17),
//           ),
//           subtitle: File(pdfPath).existsSync()
//               ? Text(_getFileSize(File(pdfPath).lengthSync()))
//               : const Text('File not found'),
//           trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   Icons.share,
//                   color: Colors.orange,
//                   size: 25,
//                 ),
//                 onPressed: onShare,
//               ),
//               IconButton(
//                 icon: const Icon(
//                   Icons.delete,
//                   color: Colors.orange,
//                   size: 25,
//                 ),
//                 onPressed: onDelete,
//               ),
//             ],
//           ),
//           onTap: onTap,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:io';

class PdfListItem extends StatelessWidget {
  final String pdfPath;
  final String pdfName;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onTap;

  const PdfListItem({
    Key? key,
    required this.pdfPath,
    required this.pdfName,
    required this.onDelete,
    required this.onShare,
    required this.onTap,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: onTap,
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
                  onPressed: onShare,
                ),
                // زر الحذف
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                  onPressed: onDelete,
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
                size: 50,
              ),
              const SizedBox(height: 10),
              // اسم الملف
              Text(
                '$pdfName.pdf',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              // حجم الملف
              File(pdfPath).existsSync()
                  ? Text(
                      _getFileSize(File(pdfPath).lengthSync()),
                      style: const TextStyle(
                        fontSize: 12,
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
            ],
          ),
        ),
      ),
    );
  }
}
