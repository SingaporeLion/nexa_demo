import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/bottom-sheet/bottom_sheet_bar.dart';
import 'package:nexa/views/components/buttons/custom_circle_animated_button.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';

import '../../../core/utils/my_color.dart';

class BottomSheetTopRow extends StatelessWidget {

  final String header;
  final double bottomSpace;
  final Color bgColor;

  const BottomSheetTopRow({
    Key? key,
    required this.header,
    this.bottomSpace = 10,
    this.bgColor = MyColor.primaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(child: BottomSheetBar(),),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(header.tr, style: interRegularDefault.copyWith(fontWeight: FontWeight.w600,color: MyColor.colorWhite)),
            CustomCircleAnimatedButton(
              onTap: (){
                Get.back();
              },
              height: 30,
              width: 30,
              backgroundColor: bgColor,
              child: const Icon(Icons.clear, color: MyColor.colorWhite, size: 15),
            )
          ],
        ),
        const CustomDivider(),
      ],
    );
  }
}
