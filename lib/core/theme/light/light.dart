import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_prime/core/theme/light/theme_component/my_appbar_theme.dart';
import '../../utils/my_color.dart';

ThemeData lightThemeData = ThemeData.light().copyWith(
  primaryColor: const Color.fromRGBO(81, 78, 183, 1),
  primaryColorDark: MyColor.primaryColor,
  secondaryHeaderColor: Colors.yellow,

  // Define the default brightness and colors.
  scaffoldBackgroundColor: MyColor.lBackgroundColor,
  appBarTheme: AppBarTheme(color: MyColor.colorWhite, foregroundColor: MyColor.lPrimaryTextColor),
  colorScheme: ColorScheme.fromSeed(
    seedColor: MyColor.primaryColor,
    brightness: Brightness.light,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: MyColor.colorWhite,
    surfaceTintColor: MyColor.transparentColor,
  ),
  cardColor: MyColor.lCardColor,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'Inter', fontSize: 57, fontWeight: FontWeight.bold, color: MyColor.lPrimaryTextColor),
    displaySmall: TextStyle(fontFamily: 'Inter', fontSize: 45, fontWeight: FontWeight.normal, color: MyColor.lPrimaryTextColor),
    bodyLarge: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold, color: MyColor.lPrimaryTextColor),
    bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.normal, color: MyColor.lPrimaryTextColor),
    bodySmall: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.normal, color: MyColor.lPrimaryTextColor),
    displayMedium: TextStyle(fontFamily: 'Inter', fontSize: 41, fontWeight: FontWeight.normal, color: MyColor.lPrimaryTextColor),
    headlineLarge: TextStyle(fontFamily: 'Inter', fontSize: 32, fontWeight: FontWeight.w600, color: MyColor.lPrimaryTextColor),
    headlineMedium: TextStyle(fontFamily: 'Inter', fontSize: 28, fontWeight: FontWeight.w500, color: MyColor.lPrimaryTextColor),
    headlineSmall: TextStyle(fontFamily: 'Inter', fontSize: 24, fontWeight: FontWeight.w500, color: MyColor.lPrimaryTextColor),
    labelMedium: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500, color: MyColor.lPrimaryTextColor),
    labelSmall: TextStyle(fontFamily: 'Inter', fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.lPrimaryTextColor),
    labelLarge: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w500, color: MyColor.lPrimaryTextColor),
    titleLarge: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w600, color: MyColor.lPrimaryTextColor),
    titleMedium: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, color: MyColor.dSecondaryTextColor),
    titleSmall: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, color: MyColor.dSecondaryTextColor),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: MyColor.primaryColor,
    selectionColor: MyColor.primaryColor,
    selectionHandleColor: MyColor.primaryColor,
  ),
  bannerTheme: MaterialBannerThemeData(
    backgroundColor: MyColor.primaryColor.withValues(alpha: .1),
  ),

  //Bottom Navbar
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: MyColor.colorWhite,
    // Selected item color
    selectedItemColor: MyColor.primaryColor,
    // Unselected item color
    unselectedItemColor: MyColor.lPrimaryTextColor,
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: MyColor.colorWhite,
  ),
  datePickerTheme: DatePickerThemeData(
    headerHelpStyle: TextStyle(fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.w600, color: MyColor.lPrimaryTextColor),
    dayStyle: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, color: MyColor.dSecondaryTextColor),
    weekdayStyle: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, color: MyColor.primaryColor),
  ),
  timePickerTheme: TimePickerThemeData(dialTextStyle: TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400, color: MyColor.dSecondaryTextColor), helpTextStyle: TextStyle(fontFamily: 'Inter', fontSize: 16, fontWeight: FontWeight.w400, color: MyColor.primaryColor)),
  //Text Filed
  inputDecorationTheme: const InputDecorationTheme(),
);
