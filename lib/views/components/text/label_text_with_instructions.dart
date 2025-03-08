import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class LabelTextInstruction extends StatelessWidget {
  final bool isRequired;
  final String text;
  final String? instructions;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const LabelTextInstruction({
    super.key,
    required this.text,
    this.textAlign,
    this.textStyle,
    this.isRequired = false,
    this.instructions,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<TooltipState> _tooltipKey = GlobalKey<TooltipState>();

    return isRequired
        ? Row(
            children: [
              Text(text.tr, textAlign: textAlign, style: textStyle ?? interSemiBoldDefault.copyWith(color: MyColor.labelTextColor)),
              const SizedBox(
                width: 2,
              ),
              if (instructions != null) ...[
                Padding(
                  padding: EdgeInsetsDirectional.only(start: Dimensions.space5, end: Dimensions.space10),
                  child: Tooltip(
                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: Theme.of(context).textTheme.titleLarge!.color?.withValues(alpha: 0.8),
                        ),
                      )),
                ),
              ],
              Text(
                '*',
                style: interSemiBoldDefault.copyWith(color: MyColor.colorRed),
              ),
            ],
          )
        : Row(
            children: [
              Text(
                text.tr,
                textAlign: textAlign,
                style: textStyle ?? interSemiBoldDefault.copyWith(color: MyColor.labelTextColor),
              ),
              if (instructions != null) ...[
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space5, end: Dimensions.space10),
                  child: Tooltip(
                      key: _tooltipKey,
                      message: "$instructions",
                      child: GestureDetector(
                        onTap: () {
                          _tooltipKey.currentState?.ensureTooltipVisible();
                        },
                        child: Icon(
                          Icons.info_outline_rounded,
                          size: Dimensions.space15,
                          color: MyColor.bodyTextColor.withValues(alpha: 0.8),
                        ),
                      )),
                ),
              ],
            ],
          );
  }
}
