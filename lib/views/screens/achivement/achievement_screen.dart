import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/controller/achievements/achievement_controller.dart';
import 'package:nexa/data/repo/achievement/achievement_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:nexa/views/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:nexa/views/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/image/my_image_widget.dart';
import 'package:nexa/views/components/shimmer/match_card_shimmer.dart';
import 'package:nexa/views/screens/achivement/widget/achievement_details_bottom_sheet_body.dart';
import 'package:nexa/views/screens/achivement/widget/achivement_card.dart';
import 'package:nexa/views/screens/achivement/widget/lock_achivement_card.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  final ScrollController scrollController = ScrollController();
  double scrollPosition = 0;
  String unlockBadgeId = "-1";

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AchievementRepo(apiClient: Get.find()));
    final controller = Get.put(AchievementController(achievementRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAchievement();
      initScroll();
    });
  }

  void initScroll() {
    scrollController.addListener(() {
      setState(() {
        scrollPosition = scrollController.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.screenBgColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: MyColor.primaryColor,
      //   title: Text(MyStrings.achievements, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
      //   leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new_rounded, color: MyColor.colorWhite)),
      // ),
      body: GetBuilder<AchievementController>(
        builder: (controller) {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: MyColor.screenBgColor,
                expandedHeight: 200,
                automaticallyImplyLeading: false,
                foregroundColor: MyColor.transparentColor,
                onStretchTrigger: () async {
                  return;
                },
                scrolledUnderElevation: 0,
                snap: true,
                elevation: 0,
                stretch: true,
                surfaceTintColor: MyColor.transparentColor,
                stretchTriggerOffset: 160,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => Get.back(),
                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_back, color: MyColor.colorBlack, size: 16),
                        ),
                      ),
                      if (scrollPosition > 110) Text(MyStrings.achievements.tr, style: interRegularLarge.copyWith(color: MyColor.primaryColor)),
                    ],
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyImageWidget(
                          imageUrl: controller.achievementRepo.apiClient.sharedPreferences.getString(SharedPreferenceHelper.userImageKey) ?? '',
                          height: 60,
                          width: 60,
                          isProfile: true,
                          radius: 30,
                        ),
                        Text(controller.achievementRepo.apiClient.getCurrencyOrUsername(isCurrency: false, isSymbol: false).toCapitalized(), style: interRegularLarge.copyWith(color: MyColor.primaryColor)),
                        Text(controller.achievementRepo.apiClient.getUserEmail(), style: interLightDefault.copyWith()),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(MyStrings.achievements.tr, style: interBoldDefault.copyWith(color: MyColor.primaryColor)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: controller.isLoading
                        ? List.generate(10, (index) => AchieveMentCardShimmer())
                        : [
                            controller.unlockBadges.isEmpty && !controller.isLoading
                                ? Container(
                                    height: 200,
                                    decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(MyStrings.noBadgesUnlocked.tr, style: interLightDefault.copyWith(color: MyColor.bodyTextColor)),
                                    ),
                                  )
                                : Column(
                                    spacing: 10,
                                    children: List.generate(
                                      controller.unlockBadges.length,
                                      (index) => AchievementCard(
                                        index: index,
                                        isOpen: unlockBadgeId == controller.unlockBadges[index].id,
                                        isUnlocked: true,
                                        onTap: () {
                                          if (unlockBadgeId == controller.unlockBadges[index].id) {
                                            setState(() {
                                              unlockBadgeId = "-1";
                                            });
                                          } else {
                                            setState(() {
                                              unlockBadgeId = controller.unlockBadges[index].id ?? "-1";
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 10),
                            Column(
                              spacing: 10,
                              children: List.generate(
                                controller.lockBadges.length,
                                (index) => LockAchievementCard(
                                  index: index,
                                  isOpen: unlockBadgeId == controller.lockBadges[index].id,
                                  isUnlocked: false,
                                  onTap: () {
                                    if (unlockBadgeId == controller.lockBadges[index].id) {
                                      setState(() {
                                        unlockBadgeId = "-1";
                                      });
                                    } else {
                                      setState(() {
                                        unlockBadgeId = controller.lockBadges[index].id ?? "-1";
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),   SizedBox(height: 10),
                          ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
