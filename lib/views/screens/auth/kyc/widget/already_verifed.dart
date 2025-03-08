import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';

import '../../../../components/image/custom_svg_picture.dart';


class AlreadyVerifiedWidget extends StatefulWidget {

  final bool isPending;

  const AlreadyVerifiedWidget({
    super.key,
    this.isPending=false
  });

  @override
  State<AlreadyVerifiedWidget> createState() => _AlreadyVerifiedWidgetState();
}

class _AlreadyVerifiedWidgetState extends State<AlreadyVerifiedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(Dimensions.space20),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColor.screenBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgPicture(image:widget.isPending ? MyImages.pendingIcon : MyImages.verifiedIcon,height: 100,width: 100,fit: BoxFit.cover,),
          const SizedBox(height: 25,),
          Text(widget.isPending?MyStrings.kycUnderReviewMsg.tr:MyStrings.kycAlreadyVerifiedMsg.tr,style: interRegularDefault.copyWith(color: MyColor.colorBlack,fontSize: Dimensions.fontExtraLarge,)),
          const SizedBox(height: 40,)
        ],
      ),
    );
  }
}
