import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';

class CustomIndicator extends StatelessWidget {

  final bool isActive;
  final Color activeColor, inactiveColor;
  final Duration duration;
  final Function? onChanged;

  const CustomIndicator({

    Key? key,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.duration,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      width: isActive ? 10.0 : 10.0,
      margin: const EdgeInsets.symmetric(horizontal: Dimensions.space5, vertical: Dimensions.space30),
      height: 10.0,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

