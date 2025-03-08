import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/social_login_controller.dart';
import 'package:nexa/data/controller/auth/social_login_repo.dart';
import 'package:nexa/views/components/buttons/custom_outlined_button.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';

class SocialLoginSection extends StatefulWidget {
  const SocialLoginSection({super.key});

  @override
  State<SocialLoginSection> createState() => _SocialLoginSectionState();
}

class _SocialLoginSectionState extends State<SocialLoginSection> {
  @override
  void initState() {
    Get.put(SocialLoginRepo(apiClient: Get.find()));
    Get.put(SocialLoginController(repo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialLoginController>(builder: (controller) {
      return Visibility(
        visible: controller.checkSocialAuthActiveOrNot(provider: 'all'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Dimensions.space10),
            Center(
              child: Text(
                MyStrings.or.tr,
                style: interRegularDefault.copyWith(color: MyColor.colorGrey2),
              ),
            ),
            const SizedBox(height: Dimensions.space10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                if (controller.checkSocialAuthActiveOrNot(provider: 'google')) ...[
                  InkWell(
                    onTap: () {
                      controller.signInWithGoogle();
                    },
                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        border: Border.all(color: MyColor.colorGrey2),
                      ),
                      child: Image.asset(
                        MyImages.google,
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ),
                ],
                if (controller.checkSocialAuthActiveOrNot(provider: 'linkedin')) ...[
                  InkWell(
                    onTap: () {
                      controller.signInWithLinkedin(context);
                    },
                    customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                        border: Border.all(color: MyColor.colorGrey2),
                      ),
                      child: Image.asset(
                        MyImages.linkedin,
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      );
    });
  }
}
