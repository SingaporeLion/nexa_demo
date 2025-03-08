import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/profile/user_profile_controller.dart';
import 'package:nexa/views/screens/bottom_nav_screens/home/widget/home_card_section.dart';

class HomeTopSection extends StatelessWidget {
  const HomeTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      builder: (userController) => Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(RouteHelper.profileScreen);
            },
            child: Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
              color: MyColor.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: MyColor.colorWhite.withValues(alpha: 0.1), shape: BoxShape.circle, image: const DecorationImage(image: AssetImage(MyImages.avatar), fit: BoxFit.fill)),
                          ),
                          const SizedBox(width: Dimensions.space20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(userController.username, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w600)), Text(userController.email, style: interRegularDefault.copyWith(color: MyColor.screenBgColor))],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: Dimensions.space50 * 1.6),
              child: HomeCardSection(),
            ),
          ),
        ],
      ),
    );
  }
}
