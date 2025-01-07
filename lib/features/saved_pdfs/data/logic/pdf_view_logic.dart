// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:share_plus/share_plus.dart';

// // class PdfListLogic {
// //   List<String> pdfPaths = [];
// //   List<String> pdfNames = [];

// //   /// تحميل مسارات وأسماء ملفات PDF من SharedPreferences
// //   Future<void> loadPdfPaths() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     pdfPaths = prefs.getStringList('pdf_paths') ?? [];
// //     pdfNames = prefs.getStringList('pdf_names') ?? [];
// //   }

// //   // /// حذف ملف PDF
// //   // Future<void> deletePdf(int index) async {
// //   //   final prefs = await SharedPreferences.getInstance();

// //   //   // تحقق من أن الفهرس ضمن النطاق
// //   //   if (index < 0 || index >= pdfPaths.length) {
// //   //     return; // الخروج إذا كان الفهرس غير صالح
// //   //   }

// //   //   // حذف المسار والاسم من القائمة
// //   //   pdfPaths.removeAt(index);
// //   //   pdfNames.removeAt(index);

// //   //   // حفظ التحديثات في SharedPreferences
// //   //   await prefs.setStringList('pdf_paths', pdfPaths);
// //   //   await prefs.setStringList('pdf_names', pdfNames);

// //   //   // إعادة تحميل القائمة بعد الحذف
// //   //   // await loadPdfPaths(); ////////////////////////
// //   // }

// //   Future<void> deletePdf(int index) async {
// //     final prefs = await SharedPreferences.getInstance();

// //     // تحقق من أن الفهرس ضمن النطاق
// //     if (index < 0 || index >= pdfPaths.length) {
// //       return; // الخروج إذا كان الفهرس غير صالح
// //     }

// //     // حذف المسار والاسم من القائمة
// //     pdfPaths.removeAt(index);
// //     pdfNames.removeAt(index);

// //     // حفظ التحديثات في SharedPreferences
// //     await prefs.setStringList('pdf_paths', pdfPaths);
// //     await prefs.setStringList('pdf_names', pdfNames);

// //     // لا حاجة لإعادة تحميل البيانات هنا
// //   }

// //   /// Function to format file size into KB, MB, or GB
// //   String getFileSize(int bytes) {
// //     if (bytes < 1024) {
// //       return '$bytes Bytes';
// //     } else if (bytes < 1024 * 1024) {
// //       return '${(bytes / 1024).toStringAsFixed(2)} KB';
// //     } else if (bytes < 1024 * 1024 * 1024) {
// //       return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
// //     } else {
// //       return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
// //     }
// //   }

// //   /// مشاركة ملف PDF
// //   void sharePdf(String path) {
// //     Share.shareXFiles(
// //       [XFile(path)],
// //       text: 'Check out this PDF!',
// //     );
// //   }
// // }

// import 'package:shared_preferences/shared_preferences.dart';

// class PdfListLogic {
//   List<String> pdfPaths = [];
//   List<String> pdfNames = [];

//   /// Load PDF paths and names from SharedPreferences
//   Future<void> loadPdfPaths() async {
//     final prefs = await SharedPreferences.getInstance();
//     pdfPaths = prefs.getStringList('pdf_paths') ?? [];
//     pdfNames = prefs.getStringList('pdf_names') ?? [];
//   }

//   /// Delete a PDF file
//   Future<void> deletePdf(int index) async {
//     final prefs = await SharedPreferences.getInstance();

//     // Remove the path and name from the list
//     pdfPaths.removeAt(index);
//     pdfNames.removeAt(index);

//     // Save the updates in SharedPreferences
//     await prefs.setStringList('pdf_paths', pdfPaths);
//     await prefs.setStringList('pdf_names', pdfNames);
//   }

//   /// Share a PDF file
//   void sharePdf(String path) {
//     // This logic would normally contain code to share the file
//     // For simplicity, it's just a placeholder
//     print('Sharing PDF from $path');
//   }

//   /// Function to format file size into KB, MB, or GB
//   String getFileSize(int bytes) {
//     if (bytes < 1024) {
//       return '$bytes Bytes'; // أقل من 1 كيلوبايت
//     } else if (bytes < 1024 * 1024) {
//       return '${(bytes / 1024).toStringAsFixed(2)} KB'; // أقل من 1 ميجابايت
//     } else if (bytes < 1024 * 1024 * 1024) {
//       return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB'; // أقل من 1 جيجابايت
//     } else {
//       return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB'; // أكبر أو يساوي 1 جيجابايت
//     }
//   }
// }
