import 'package:flutter/material.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';


class CustomRow extends StatelessWidget {

  const CustomRow({
  Key? key,
  required this.firstText,
  required this.lastText,
  this.showDivider = true
  }) : super(key: key);

  final String firstText,lastText;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText,style: interRegularDefault.copyWith(color: MyColor.labelTextColor,fontWeight: FontWeight.w600),overflow: TextOverflow.ellipsis,maxLines: 1,)),
            Flexible(child:Text(lastText,maxLines:2,style:interRegularDefault.copyWith(color: MyColor.labelTextColor),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
          ],
        ),
        const SizedBox(height: 5,),
        showDivider?  const Divider(color: MyColor.lineColor,) : const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    );
  }
}
