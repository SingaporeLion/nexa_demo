import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class SmallText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  final Color textColor;
  const SmallText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularSmall,
    this.textColor = MyColor.colorWhite
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(color: textColor),
    );
  }
}
