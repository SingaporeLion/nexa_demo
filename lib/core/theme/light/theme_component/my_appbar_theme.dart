

import 'package:flutter/material.dart';
import 'package:nexa/core/utils/styles.dart';

import '../../../utils/my_color.dart';

class MyAppbarTheme{

  static AppBarTheme get lightAppbarTheme =>  AppBarTheme(
    backgroundColor: MyColor.primaryColor,
    elevation: 0,
    titleTextStyle: interRegularLarge.copyWith(color: MyColor.colorWhite),
    iconTheme: const IconThemeData(
      size: 20,
      color: MyColor.colorWhite
    )
  );

  static AppBarTheme get darkAppbarTheme =>  AppBarTheme(
      backgroundColor: MyColor.primaryColor,
      elevation: 0,
      titleTextStyle: interRegularLarge.copyWith(color: MyColor.colorWhite),
      iconTheme: const IconThemeData(
          size: 20,
          color: MyColor.colorWhite
      )
  );

}