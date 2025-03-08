import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

class MySliderTheme {
  static SliderThemeData get lightSliderTheme => SliderThemeData(
        trackHeight: 2, // Adjust track height for better visibility
        thumbColor: Colors.blue,
        activeTrackColor: MyColor.primaryColor,
        inactiveTrackColor: MyColor.primaryColor.withValues(alpha: .9),
      );

  static SliderThemeData get darkSliderTheme => SliderThemeData(
        trackHeight: 2,
        thumbColor: Colors.blue,
        activeTrackColor: MyColor.primaryColor,
        inactiveTrackColor: MyColor.primaryColor.withValues(alpha: .9),
      );
}
