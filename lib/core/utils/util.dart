import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:url_launcher/url_launcher.dart';

class MyUtils {
  static void splashScreenUtil() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyColor.primaryColor, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.primaryColor, systemNavigationBarIconBrightness: Brightness.dark));
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: MyColor.getShadowColor().withValues(alpha: 0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static void allScreenUtil() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyColor.primaryColor, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.screenBgColor, systemNavigationBarIconBrightness: Brightness.dark));
  }

  static dynamic getShadow({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return [
      BoxShadow(
        blurRadius: blurRadius ?? 15.0,
        offset: offset ?? const Offset(0, 25),
        color: color ?? Colors.grey.shade500.withValues(alpha: 0.6),
        spreadRadius: spreadRadius ?? -35.0,
      ),
    ];
  }

  static void authScreenUtils() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyColor.primaryColor, statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.screenBgColor, systemNavigationBarIconBrightness: Brightness.dark));
  }

  static makePortraitOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static makePortraitAndLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static Future<void> launchUrlToBrowser(String downloadUrl) async {
    try {
      final Uri url = Uri.parse(downloadUrl);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
