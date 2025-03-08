import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';

class CustomCard extends StatelessWidget {

  final Widget child;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final Color shadowColor;
  final Color cardBgColor;
  final VoidCallback? onPressed;
  final bool showShadow;

  const CustomCard({
    Key? key,
    this.borderRadius = Dimensions.defaultRadius,
    this.shadowColor = MyColor.primaryColor,
    this.cardBgColor = MyColor.colorWhite,
    this.onPressed,
    required this.child,
    this.showShadow = false,
    this.verticalPadding = Dimensions.space20,
    this.horizontalPadding = Dimensions.space15
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return showShadow?Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
            BoxShadow(
              color: MyColor.screenBgColor,
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0.0, 1.0), // changes position of shadow
            )
        ]
      ),
      child: child,
    ):GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
