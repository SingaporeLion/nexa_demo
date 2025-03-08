import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class CardListItem extends StatelessWidget {
  final String image;
  final String title;
  final String quantity;
  final bool alignEnd;

  const CardListItem({Key? key, required this.image, required this.title, required this.quantity, this.alignEnd = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: MyColor.screenBgColor.withValues(alpha: 0.5), shape: BoxShape.circle),
          child: Image.asset(image, color: Colors.purple, height: 15, width: 15),
        ),
        const SizedBox(width: Dimensions.space10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
            const SizedBox(height: Dimensions.space5),
            Text(quantity, style: interRegularExtraLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }
}
