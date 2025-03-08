

import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

class MyBottomAppbarTheme {

  static BottomAppBarTheme get lightBottomAppbarTheme => BottomAppBarTheme(
   color: MyColor.getBottomNavBgColor(),
   height: 90,
   surfaceTintColor: MyColor.getSurfaceTintColor(),
    //shadowColor: ,
    //padding:
  );

  static BottomAppBarTheme get darkBottomAppbarTheme => BottomAppBarTheme(
    color: MyColor.getBottomNavBgColor(),
    height: 90,
    surfaceTintColor: MyColor.getSurfaceTintColor(),
    //shadowColor: ,
    //padding:
  );

}