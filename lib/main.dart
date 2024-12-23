import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/image_to_text/data/provider/image_to_text_provider.dart';
import 'package:scanner_app/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ImageToTextProvider()),
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
