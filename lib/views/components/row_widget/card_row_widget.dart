import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class CardRow extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;

  const CardRow({Key? key, this.alignmentEnd = false, required this.header, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header.tr,
          style: interRegularSmall.copyWith(color: MyColor.colorBlack.withValues(alpha: 0.6)),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.space5),
        Text(body.tr, style: interRegularDefault.copyWith(color: MyColor.getTextColor(), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
      ],
    );
  }
}
