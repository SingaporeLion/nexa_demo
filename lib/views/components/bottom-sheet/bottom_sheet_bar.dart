import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

class BottomSheetBar extends StatelessWidget {
  const BottomSheetBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 4,
        width: 25,
        decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
