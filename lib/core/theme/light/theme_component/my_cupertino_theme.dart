import 'package:flutter/cupertino.dart';
import 'package:nexa/core/utils/my_color.dart';

class MyCupertinoTheme {

  static CupertinoThemeData get lightCupertinoTheme => CupertinoThemeData(
    primaryColor: MyColor.primaryColor,
    scaffoldBackgroundColor: MyColor.screenBgColor,
    brightness: Brightness.light
  );

  static CupertinoThemeData get darkCupertinoTheme => CupertinoThemeData(
    primaryColor: MyColor.primaryColor,
    scaffoldBackgroundColor: MyColor.screenBgColor,
    brightness: Brightness.light
  );

}