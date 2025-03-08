import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class BottomSheetLabelText extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;

  const BottomSheetLabelText({
    Key? key,
    required this.text,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      style: interRegularDefault.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500)
    );
  }
}
