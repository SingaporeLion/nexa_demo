import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/data/controller/common/theme_controller.dart';

class MyColor {


                  // Dark Theme
  static const Color dBackgroundColor      = Color(0xFF191E29);
  static const Color dPrimaryTextColor     = Color(0xFFFFFFFF);
  static const Color dSecondaryTextColor   = Color(0xFFB0B0B0);
  static const Color dAccentSecondaryColor = Color(0xFFFF1F6D);
  static const Color dHighlightColor       = Color(0xFF42B2B8);
  static const Color dCardColor            = Color(0xFF232936);
  static const Color dBorderColor          = Color(0xff8b929c);
  static const Color dShadowColor          = Color(0xff2B303D);
        //light theme
  static const Color lPrimaryTextColor     = Color(0xFF262626);
  static const Color ticketDateColor       = Color(0xff888888);
  static const Color ticketDetails         = Color(0xff5D5D5D);
  static const Color cardBorderColor       = Color(0xffE7E7E7);
  static const Color lSecondaryTextColor   = Color(0xFF777777);
  static const Color lAccentSecondaryColor = Color(0xFFFD1F6C);
  static const Color secondaryColor        = Color(0xFFF6F7FE);
  static const Color lHighlightColor       = Color(0xFF42B2B8);
  static const Color lCardColor            = Color(0xFFFFFFFF);
  static const Color lBorderColor          = Color(0xffeff1f3);
  static const Color lShadowColor          = Color(0xffEAEAEA);


  static const Color primaryColor          = Color(0xff5700a0);
  static const Color screenBgColor         = Color(0xffF1F3F4);
  static const Color secondaryScreenBgColor= Color(0xFFFCFEFF);
  static const Color colorWhite            = Color(0xffffffff);
  static const Color circleContainerColor1 = Color(0xffE9F6EF);
  static const Color circleContainerColor2 = Color(0xffCEF1DE);
  static const Color smallCircleColor      = Color(0xffB6E3CA);
  static const Color pendingColor          = Colors.orange;

  static const Color titleColor = Color(0xff373e4a);

  static const Color transparentColor = Colors.transparent;
  static const Color lineColor        = Color(0xffCAC4C4);

  static const Color colorBlack                  = Color(0xff454545);
  static const Color lBackgroundColor            = Color(0xFFFFFFFF);
  static const Color borderColor                 = Color(0xffD9D9D9);
  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);
  static const Color inputFillColor              = Colors.transparent;
  static const Color textFieldFillColor          = Color(0xffCFCEDB);
  static const Color textFieldEnableBorderColor  = primaryColor;
  static const Color textFieldLabelColor         = Color(0xff4d4d4d);
  static const Color primarySubTitleColor        = Color(0xff777777);
  static const Color hintTextColor               = Color(0xffb6afaf);
  static const Color activeIndicatorColor        = Color(0xFFF8BF27);
  static const Color labelTextColor              = accountEnsureTextColor;
  static const Color accountEnsureTextColor      = Color(0xff8F8F8F);
  static const Color bodyTextColor               = Color(0xFF757575);

  static const Color textFieldBorderColor = Color(0xffCAC4C4);
  static const Color otpTextFieldBorder   = Color(0xffCAC4C4);
  static const Color colorGrey2           = Color(0xffDADADA);
  static const Color colorGrey3           = Color(0xFFE7E7E7);

  static const Color colorRed   = Colors.red;
  static const Color colorWithe = Colors.white;
  static const Color colorGrey  = Colors.grey;
  static const Color greenP     = Color(0xFF56009F);

  static const Color greenSuccessColor       = greenP;
  static const Color redCancelTextColor      = Color(0xFFF93E2C);
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);

  
  static Color getTextFieldDisableBorder() {
    return textFieldDisableBorderColor;
  }
    static Color getTextColor() {
    return colorBlack;
  }
    static Color getPrimaryTextColor() {
    return Get.find<ThemeController>().darkTheme ? dPrimaryTextColor: lPrimaryTextColor;
  }

   static Color getLabelTextColor() {
    return labelTextColor;
  }

    static Color getBottomNavBgColor() {
    return colorWhite;
  }


  static Color getTextFieldFillColor() {
    return textFieldFillColor;
  }

  static Color getTextFieldEnableBorder() {
    return textFieldEnableBorderColor;
  }
   static Color getHintTextColor() {
    return hintTextColor;
  }
   static Color getSurfaceTintColor() {
    return colorWhite;
  }
 static Color getCardBgColor() {
    return Get.find<ThemeController>().darkTheme ? dCardColor: lCardColor;
  }

    static Color getBackgroundColor() {
    return Get.find<ThemeController>().darkTheme ? dBackgroundColor: lBackgroundColor;
  }
  static Color getShadowColor() {
    return Get.find<ThemeController>().darkTheme ? dSecondaryTextColor: lShadowColor;
  }
}
