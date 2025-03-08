import 'package:flutter/material.dart';
import 'package:nexa/core/utils/styles.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle textStyle;
  final int maxLines;
  final Color? textColor;

  const DefaultText({
    Key? key,
    required this.text,
    this.textAlign,
    this.textStyle = interRegularDefault,
    this.maxLines = 2,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: textStyle.copyWith(color: textColor),
      maxLines: maxLines,
    );
  }
}
