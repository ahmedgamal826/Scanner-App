import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scanner_app/features/image_to_text/presentation/views/widgets/show_snack_bar.dart';

class BottomScanDataContainer extends StatelessWidget {
  const BottomScanDataContainer({
    super.key,
    required this.qrData,
  });

  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black.withOpacity(0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                qrData,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy, color: Colors.white),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: qrData));

                customShowSnackBar(context: context, content: 'Link copied!');
              },
            ),
          ],
        ),
      ),
    );
  }
}
