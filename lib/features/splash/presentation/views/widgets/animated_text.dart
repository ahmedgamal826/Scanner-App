import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final VoidCallback onFinished;

  const AnimatedText({Key? key, required this.onFinished}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(
          'Scanner App',
          textStyle: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 150),
        ),
      ],
      totalRepeatCount: 1,
      pause: const Duration(milliseconds: 900),
      displayFullTextOnTap: true,
      stopPauseOnTap: true,
      onFinished: onFinished,
    );
  }
}
