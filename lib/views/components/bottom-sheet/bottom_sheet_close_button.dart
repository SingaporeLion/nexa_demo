import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';

class BottomSheetCloseButton extends StatelessWidget {
  final Color? iconColor;
  const BottomSheetCloseButton({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 30,
        width: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Dimensions.space5),
        decoration: BoxDecoration(color: iconColor?.withValues(alpha: .1) ?? MyColor.colorWhite.withValues(alpha: .1), shape: BoxShape.circle),
        child: Icon(Icons.clear, color: iconColor ?? MyColor.colorWhite, size: 15),
      ),
    );
  }
}
