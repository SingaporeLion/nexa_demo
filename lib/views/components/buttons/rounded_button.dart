import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
   final bool isColorChange;
    final bool hasCornerRadious;

  const RoundedButton({
    Key? key,
     this.isColorChange = false,
      this.hasCornerRadious=false,
    this.width=1,
    this.cornerRadius=6,
    required this.text,
    required this.press,
    this.isOutlined=false,
    this.horizontalPadding=35,
    this.verticalPadding=18,
    this.color = MyColor.primaryColor,
    this.textColor = Colors.white,
  }):super(key: key) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isOutlined? Material(
      child: InkWell(
        onTap: press,
        child: Container(
            padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            width: size.width * width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                color: color
            ),
            child: Center(child: Text(text,style:TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.w500)))),
      ),
    ): SizedBox(
      width: size.width * width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: MyColor.transparentColor,
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          textStyle: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}