// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:scanner_app/features/write_page/data/provider/whiteboard_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class SavedImagesPage extends StatelessWidget {
//   final List<Map<String, dynamic>> savedImages;

//   SavedImagesPage({required this.savedImages});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Images'),
//         backgroundColor: Colors.orange,
//       ),
//       body: savedImages.isEmpty
//           ? Center(
//               child: Text(
//                 'No images saved yet.',
//                 style: TextStyle(fontSize: 18, color: Colors.grey),
//               ),
//             )
//           : ListView.builder(
//               itemCount: savedImages.length,
//               itemBuilder: (context, index) {
//                 final imageInfo = savedImages[index];
//                 final provider =
//                     Provider.of<WhiteboardProvider>(context, listen: false);
//                 final decodedImage = Image.memory(
//                   Base64Decoder().convert(imageInfo['image']),
//                 );
//                 final dateTime = DateTime.parse(imageInfo['dateTime']);

//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//                   child: Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // التاريخ والوقت
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.orange,
//                             borderRadius:
//                                 BorderRadius.vertical(top: Radius.circular(12)),
//                           ),
//                           child: Text(
//                             DateFormat('yyyy-MM-dd – HH:mm a').format(dateTime),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.orange, width: 4),
//                             borderRadius: BorderRadius.vertical(
//                                 bottom: Radius.circular(12)),
//                           ),
//                           child: Stack(
//                             alignment: Alignment.topRight,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.vertical(
//                                     bottom: Radius.circular(8)),
//                                 child: decodedImage,
//                               ),
//                               IconButton(
//                                 icon: Icon(Icons.delete, color: Colors.red),
//                                 onPressed: () {
//                                   // Show the AwesomeDialog to confirm deletion
//                                   AwesomeDialog(
//                                     context: context,
//                                     dialogType: DialogType.warning,
//                                     animType: AnimType.topSlide,
//                                     title: 'Confirm Deletion',
//                                     desc:
//                                         'Are you sure you want to delete this image?',
//                                     btnCancelText: 'Cancel',
//                                     btnOkText: 'Delete',
//                                     btnCancelOnPress: () {},
//                                     btnOkOnPress: () {
//                                       // Delete the image
//                                       provider.deleteImage(index);
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context).pop();
//                                     },
//                                   ).show();
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
         