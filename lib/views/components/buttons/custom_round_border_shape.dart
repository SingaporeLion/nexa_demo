import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class RoundedBorderContainer extends StatelessWidget {

  const RoundedBorderContainer({super.key,
    required this.text,
    this.borderColor= MyColor.primaryColor,
    this.bgColor= MyColor.primaryColor,
    this.horizontalPadding=12,
    this.verticalPadding=5,
    this.textColor= MyColor.primaryColor});

  final Color bgColor,textColor,borderColor;
  final double horizontalPadding,verticalPadding;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding,vertical: verticalPadding),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border:Border.all(color: borderColor,width: 1.5)
      ),
      child: Text(
        text.tr,
        style: interBoldDefault.copyWith(color:textColor,fontSize: Dimensions.fontSmall)
      ),
    );
  }
}
