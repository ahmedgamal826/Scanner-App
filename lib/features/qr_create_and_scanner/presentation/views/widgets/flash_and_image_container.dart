// import 'package:flutter/material.dart';

// class FlashAndImageContainer extends StatelessWidget {
//   const FlashAndImageContainer({
//     super.key,
//     required this.width,
//     required this.flashColor,
//     required this.flashOnPressed,
//     required this.imageOnPressed,
//   });

//   final double width;
//   final Color flashColor;
//   final void Function()? flashOnPressed;
//   final void Function()? imageOnPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 135, // Adjust as needed to position it correctly
//       left: 120,
//       right: 120,
//       child: Container(
//         width: width * 0.4,
//         color: Colors.black.withOpacity(0.7),
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: Icon(
//                 Icons.flash_on,
//                 color: flashColor,
//               ),
//               onPressed: flashOnPressed,
//             ),
//             IconButton(
//               icon: const Icon(Icons.photo, color: Colors.white),
//               onPressed: imageOnPressed,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FlashAndImageContainer extends StatelessWidget {
  const FlashAndImageContainer({
    super.key,
    required this.width,
    required this.flashColor,
    required this.flashOnPressed,
    required this.imageOnPressed,
  });

  final double width;
  final Color flashColor;
  final void Function()? flashOnPressed;
  final void Function()? imageOnPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 135, // Adjust as needed to position it correctly
      left: 120,
      right: 120,
      child: Container(
        width: width * 0.4,
        color: Colors.black.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(
                Icons.flash_on,
                color: flashColor,
              ),
              onPressed: flashOnPressed,
            ),
            IconButton(
              icon: const Icon(Icons.photo, color: Colors.white),
              onPressed: imageOnPressed,
            ),
          ],
        ),
      ),
    );
  }
}
