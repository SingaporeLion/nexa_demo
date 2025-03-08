import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/styles.dart';

import '../../../core/utils/my_color.dart';
import '../divider/custom_divider.dart';



class CustomRow extends StatelessWidget {

  final String firstText,lastText;
  final bool isStatus,isAbout,showDivider;
  final Color? statusTextColor;
  final bool hasChild;
  final Widget? child;

  const CustomRow({Key? key,
    this.child,
    this.hasChild=false,
    this.statusTextColor,
    required this.firstText,
    required this.lastText,
    this.isStatus=false,
    this.isAbout=false,
    this.showDivider=true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasChild?Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText.tr,style: interRegularDefault.copyWith(color: MyColor.getTextColor()),overflow: TextOverflow.ellipsis,maxLines: 1,)),
            child ?? const SizedBox(),
          ],
        ),
        const SizedBox(height: 5,),
        showDivider? const Divider(color: MyColor.colorGrey) : const SizedBox(),
        showDivider? const SizedBox(height: 5,) : const SizedBox(),
      ],
    ): isAbout ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(firstText.tr,style: interRegularDefault.copyWith(color: MyColor.colorWhite)),
        const SizedBox(height: 4,),
       Text(lastText.tr,style: interRegularDefault.copyWith(fontFamily:"Inter",color: isStatus ? statusTextColor : MyColor.colorWhite),),
        const SizedBox(height: 5,),
      ],
    ) :
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: Text(firstText.tr,style: interRegularDefault.copyWith(color: MyColor.colorWhite,fontFamily: 'Inter'),overflow: TextOverflow.ellipsis,maxLines: 1,)),
          //  isStatus ? StatusWidget(status: lastText, color: MyColor.greenP,) : Flexible(child:Text(lastText.tr, maxLines:2, style: interRegularDefault.copyWith(fontFamily:"Inter",color: isStatus ? MyColor.greenSuccessColor : MyColor.colorWhite),overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,))
          ],
        ),
        const SizedBox(height: 5),
        showDivider ? const CustomDivider() : const SizedBox(),
        showDivider ? const SizedBox(height: 5,) : const SizedBox(),
      ],
    );
  }
}
