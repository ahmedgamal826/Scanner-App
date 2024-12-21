import 'package:flutter/material.dart';
import 'package:scanner_app/features/splash/data/splash_logic.dart';
import 'package:scanner_app/features/splash/presentation/views/widgets/animated_text.dart';
import 'package:scanner_app/features/splash/presentation/views/widgets/logo_animation.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoAnimation(),
              const SizedBox(height: 20),
              AnimatedText(
                onFinished: () => SplashLogic.NavigateToChatHomeView(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
