import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/form_row.dart';

class LabelText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool required;
  final Color textColor;

  const LabelText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.textColor = MyColor.labelTextColor,
    this.required = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return required?Row(
            children: [
              Text(text.tr, textAlign: textAlign, style: textStyle ?? interRegularDefault.copyWith(color: MyColor.getLabelTextColor())),
              const SizedBox(
                width: 2,
              ),
              Text(
                '*',
                style: interSemiBoldDefault.copyWith(color: MyColor.colorRed),
              )
            ],
          )
        : Text(
            text.tr, 
            textAlign: textAlign,
            style: textStyle ?? interSemiBoldDefault.copyWith(color: MyColor.colorBlack),
          );
  }
}
