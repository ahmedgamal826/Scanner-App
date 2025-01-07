import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/image_to_text/data/provider/image_to_text_provider.dart';
import 'package:scanner_app/features/pdf_to_text/data/provider/pdf_to_text_provider.dart';
import 'package:scanner_app/features/splash/presentation/views/splash_view.dart';
import 'package:scanner_app/features/write_page/data/provider/whiteboard_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageToTextProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PdfProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WhiteboardProvider(),
        ),
      ],
      child: const ScannerApp(),
    ),
  );
}

class ScannerApp extends StatelessWidget {
  const ScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
