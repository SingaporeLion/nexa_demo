import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/environment.dart';
import 'package:nexa/views/components/image/my_image_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/route/route.dart';

class AuthLayout extends StatefulWidget {
  final String imageUrl;
  final Widget child;
  final double bottomSpace;
  final bool showBackButton;
  final bool isLanguageShow;
  final double imageHeight;
  final double imageWidth;

  const AuthLayout({super.key, required this.imageUrl, required this.child, this.bottomSpace = -Dimensions.space20, this.showBackButton = false, this.isLanguageShow = true, this.imageHeight = Dimensions.imageHeight, this.imageWidth = Dimensions.imageWidth});

  @override
  State<AuthLayout> createState() => _AuthLayoutState();
}

class _AuthLayoutState extends State<AuthLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: MediaQuery.of(context).size.height),
        Positioned(
          top: -160,
          right: -80,
          child: Container(
            height: 420,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: MyColor.circleContainerColor2, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          top: -170,
          left: -10,
          right: -10,
          child: Container(
            height: 420,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: MyColor.circleContainerColor1, shape: BoxShape.circle),
          ),
        ),
        widget.showBackButton
            ? Positioned(
                top: Dimensions.space40,
                left: Dimensions.space15,
                child: InkWell(
                  onTap: () {
                    Get.offAllNamed(RouteHelper.loginScreen);
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, color: MyColor.colorBlack, size: 16),
                  ),
                ),
              )
            : const SizedBox(),
        Positioned(
          top: 60,
          left: Dimensions.space50,
          right: Dimensions.space50,
          child: Image.asset(widget.imageUrl, height: widget.imageHeight, width: widget.imageWidth),
        ),
        Positioned(
          top: 270,
          right: -25,
          child: Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(color: MyColor.smallCircleColor, shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: widget.bottomSpace,
          left: -25,
          child: Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(color: MyColor.smallCircleColor, shape: BoxShape.circle),
          ),
        ),
        widget.isLanguageShow
            ? Positioned(
                top: 70,
                right: Dimensions.space10,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.languageScreen);
                  },
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColor.borderColor, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        if (Get.find<SharedPreferences>().getString(SharedPreferenceHelper.languageImagePath) == null)
                          const Icon(
                            Icons.g_translate,
                            color: MyColor.primaryColor,
                          )
                        else
                          MyImageWidget(
                            imageUrl: Get.find<SharedPreferences>().getString(SharedPreferenceHelper.languageImagePath) ?? "",
                            width: 20,
                            height: 20,
                          ),
                        const SizedBox(
                          width: Dimensions.space3,
                        ),
                        Text(
                          Get.find<SharedPreferences>().getString(SharedPreferenceHelper.languageCode)?.toUpperCase() ?? Environment.defaultLangCode.toUpperCase(),
                          style: interRegularDefault.copyWith(color: MyColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Flex(
          direction: Axis.vertical,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 300),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                child: widget.child,
              ),
            ),
            const SizedBox(height: Dimensions.space20),
          ],
        )

        // Positioned(
        //   top: 300,
        //   left: 15,
        //   right: 15,
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
        //     width: MediaQuery.of(context).size.width,
        //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
        //     alignment: Alignment.center,
        //     decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
        //     child: SingleChildScrollView(
        //       physics: const BouncingScrollPhysics(),
        //       child: Center(child: widget.child),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
