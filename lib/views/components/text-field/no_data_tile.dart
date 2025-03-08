import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';

class NoDataTile extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onTap;
  final bool hasActionButton;
  final double height;
  const NoDataTile({
    super.key,
    required this.title,
    this.onTap,
    this.hasActionButton = false,
    this.buttonText = "",
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(Dimensions.space8),
        child: Column(
          children: [
            Container(
              height: height,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15),
              decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.all(Radius.circular(Dimensions.space8))),
              child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(MyImages.noDataImage,colorFilter:const ColorFilter.mode(Colors.white, BlendMode.srcIn),),
                   const SizedBox(height: Dimensions.space10),
                  Text(
                    title.tr ?? "",
                    style: interRegularDefault.copyWith(color: MyColor.colorWhite, fontFamily: "Inter"),
                  ),
                  const SizedBox(height: Dimensions.space25),
                  hasActionButton
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: RoundedButton(
                            hasCornerRadious: true,
                            isColorChange: true,
                            textColor: MyColor.colorBlack,
                            verticalPadding: Dimensions.space15,
                            cornerRadius: Dimensions.space8,
                            color: MyColor.primaryColor,
                            text: buttonText,
                            press: onTap ?? () {},
                          ),
                      )
                      : const SizedBox(),
                ],
              )),
            ),
            const SizedBox(height: Dimensions.space30),
          ],
        ));
  }
}
