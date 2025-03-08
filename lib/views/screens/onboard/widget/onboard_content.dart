import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/styles.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_images.dart';
import '../../../../data/controller/onboard/onboard_controller.dart';

class OnboardContent extends StatelessWidget {
  final OnboardController controller;
  final int index;
  final String title;
  final String subTitle;
  final String? image;

  const OnboardContent({super.key, required this.controller, required this.index, required this.title, required this.subTitle, this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: Dimensions.onBoardPadding,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .03),
              Image.asset(image ?? MyImages.onboardFirstImage, height: size.height * .25),
              SizedBox(height: size.height * .04),
              Text(title.tr.toTitleCase(), textAlign: TextAlign.center, style: boldOverLarge.copyWith(fontSize: 20, color: MyColor.titleColor)),
              SizedBox(height: size.height * .01),
              Text(subTitle.tr.toCapitalized(), textAlign: TextAlign.center, style: interRegularDefault.copyWith(fontSize: 16, color: MyColor.titleColor.withValues(alpha: .7)))
            ],
          ),
        ),
      ),
    );
  }
}
