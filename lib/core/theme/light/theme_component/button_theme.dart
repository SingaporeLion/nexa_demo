import '../../../utils/my_color.dart';
import 'package:flutter/material.dart';

class MyButtonTheme {
  static ButtonThemeData get lightButtonTheme => ButtonThemeData(buttonColor: MyColor.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));

  static ButtonThemeData get darkButtonTheme => ButtonThemeData(buttonColor: MyColor.primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)));

  static SegmentedButtonThemeData get lightSegmentButtonTheme => const SegmentedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(MyColor.primaryColor),
      ));

  static SegmentedButtonThemeData get darkSegmentButtonTheme => const SegmentedButtonThemeData(
          style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(MyColor.primaryColor),
      ));

  static ElevatedButtonThemeData get lightElevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: MyColor.primaryColor),
      );

  static ElevatedButtonThemeData get darkElevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: MyColor.primaryColor),
      );

  static FilledButtonThemeData get lightFilledButtonTheme => const FilledButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(MyColor.primaryColor)),
      );

  static FilledButtonThemeData get darkFilledButtonTheme => const FilledButtonThemeData(
        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(MyColor.primaryColor)),
      );

  /*static FilledButtonThemeData get lightFilledButtonTheme =>  const FilledButtonThemeData(
    style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(MyColor.primaryColor)),
  );*/
}

class TestColor extends MaterialStateColor {
  TestColor(super.defaultValue);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return Colors.blue[800]!;
    } else if (states.contains(MaterialState.hovered)) {
      return Colors.blue[700]!;
    } else {
      return Colors.blue[600]!;
    }
  }
}
