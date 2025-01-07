import 'package:flutter/material.dart';

class StrokeWidthSlider extends StatelessWidget {
  StrokeWidthSlider({
    super.key,
    required this.onChanged,
    required this.value,
  });

  void Function(double)? onChanged;
  double value;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        overlayColor: Colors.blue.withAlpha(32),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
      ),
      child: Slider(
        value: value,
        min: 1.0,
        max: 10.0,
        onChanged: onChanged,
      ),
    );
  }
}
