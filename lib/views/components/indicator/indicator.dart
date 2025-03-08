import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:nexa/core/utils/my_color.dart';

class LoadingIndicator extends StatelessWidget {
  final double strokeWidth;
  const LoadingIndicator({Key? key, this.strokeWidth = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: MyColor.colorWhite, boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: .8),
          blurRadius: 2.0,
        ),
      ]),
      child: const CircularProgressIndicator(
        color: MyColor.primaryColor,
        strokeWidth: 3,
      ),
    );
  }
}
