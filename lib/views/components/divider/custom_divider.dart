import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';

class CustomDivider extends StatelessWidget {
  final double space;
  final Color dividerColor;
  const CustomDivider({Key? key, this.space = Dimensions.space10, this.dividerColor = MyColor.lineColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: space),
        Divider(color: dividerColor.withValues(alpha: 0.2), height: 0.5, thickness: 1),
        SizedBox(height: space),
      ],
    );
  }
}
