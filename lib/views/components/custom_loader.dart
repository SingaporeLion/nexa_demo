import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

import 'indicator/indicator.dart';

class CustomLoader extends StatelessWidget {
  final bool isFullScreen;
  final bool isPagination;
  final double strokeWidth;
    final Color loaderColor;

  const CustomLoader({
    Key? key,
    this.isFullScreen = false,
    this.isPagination = false,
    this.strokeWidth = 1,
    this.loaderColor = MyColor.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFullScreen?SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: const Center(
        child: LoadingIndicator()
      ),
    ):isPagination?Center(child: Padding(
        padding: const EdgeInsets.all(10),
        child: LoadingIndicator(strokeWidth: strokeWidth,))):
    const Center(
      child: LoadingIndicator(),
    );
  }
}
