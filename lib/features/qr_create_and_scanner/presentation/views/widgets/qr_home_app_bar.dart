import 'package:flutter/material.dart';

class QrHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const QrHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        'QR Code Options',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 23,
          fontStyle: FontStyle.italic,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.orange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
