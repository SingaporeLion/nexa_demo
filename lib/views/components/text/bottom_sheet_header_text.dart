import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/styles.dart';

class BottomSheetHeaderText extends StatelessWidget {

  final String text;
  final TextAlign? textAlign;

  const BottomSheetHeaderText({
    Key? key,
    required this.text,
    this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: interRegularLarge.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
