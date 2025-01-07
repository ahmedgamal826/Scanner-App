import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scanner_app/features/text_to_speech/data/provider/text_to_speech_provider.dart';
import 'package:scanner_app/features/text_to_speech/presentation/views/widgets/custom_button_sound.dart';
import 'package:scanner_app/features/text_to_speech/presentation/views/widgets/custom_text_field.dart';

class TextToSpeechView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TextToSpeechProvider(),
      child: Scaffold(
        backgroundColor: Colors.orange.shade50,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text(
            'Text To Speech',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Consumer<TextToSpeechProvider>(
          builder: (context, provider, child) {
            double height = MediaQuery.of(context).size.height;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Lottie.asset(
                    'assets/jsons/sound.json',
                    height: height * 0.18,
                    repeat: provider.isPlaying,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Enter text here in any language",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: provider.formKey, // Use the formKey from the provider
                    child: CustomTextField(
                      textDirection: provider.textDirection,
                      controller: provider.textController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButtonSound(
                        btnText: 'Play',
                        onPressed: () async {
                          if (provider.formKey.currentState?.validate() ??
                              false) {
                            await provider.speak();
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      CustomButtonSound(
                        onPressed: provider.stop,
                        btnText: 'Stop',
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
