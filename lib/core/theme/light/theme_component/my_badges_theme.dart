

import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class MyBadgeTheme {

  static BadgeThemeData get lightBadgeTheme => const BadgeThemeData(
    backgroundColor: MyColor.primaryColor,
    textColor: MyColor.primaryColor,
    textStyle: interRegularSmall
  );

  static BadgeThemeData get darkBadgeTheme => const BadgeThemeData(
      backgroundColor: MyColor.primaryColor,
      textColor: MyColor.primaryColor,
      textStyle: interRegularSmall
  );

}