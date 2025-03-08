import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';


void showCustomSnackBar(String message, BuildContext context, {bool isError = true, bool text= false}) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(message, style: interRegularDefault.copyWith(fontSize: Dimensions.fontSmall, color: MyColor.colorWhite),),
    backgroundColor: isError ? Colors.red : MyColor.primaryColor,
    duration:const Duration(milliseconds: 3000),
    isDismissible: true,
    borderRadius: 10,
    margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
    snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve:  Curves.fastOutSlowIn));
}
