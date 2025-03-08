

import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

class MySnackBarTheme {

  static SnackBarThemeData get lightSnackbarThemeData => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,  // Ensure visibility over content
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: MyColor.getTextColor()),
  );

  static SnackBarThemeData get darkSnackbarThemeData => SnackBarThemeData(
    behavior: SnackBarBehavior.floating,  // Ensure visibility over content
    backgroundColor: Colors.white,
    contentTextStyle: TextStyle(color: MyColor.getTextColor()),
  );

}