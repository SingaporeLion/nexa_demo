import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/controller/achievements/achievement_controller.dart';
import 'package:nexa/views/components/animated_widget/expanded_widget.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/image/my_image_widget.dart';

class LockAchievementCard extends StatefulWidget {
  final int index;
  final bool isOpen;
  final bool isUnlocked;
  final VoidCallback onTap;
  const LockAchievementCard({super.key, required this.index, required this.isOpen, required this.isUnlocked, required this.onTap});

  @override
  State<LockAchievementCard> createState() => _LockAchievementCardState();
}

class _LockAchievementCardState extends State<LockAchievementCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AchievementController>(builder: (controller) {
      return Container(
        decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(10), border: Border.all(color: MyColor.borderColor)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyImageWidget(
                  imageUrl: "${UrlContainer.baseUrl}${controller.badgePath}/${controller.lockBadges[widget.index].image ?? ""}",
                  height: 60,
                  width: 60,
                  radius: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.lockBadges[widget.index].name ?? "", style: interSemiBoldDefault.copyWith()),
                      Text("Main Earning : ${controller.achievementRepo.apiClient.getCurrencyOrUsername(isSymbol: true)}${MyConverter.formatNumber(controller.lockBadges[widget.index].earningAmount ?? '0.00')}", style: interRegularDefault.copyWith()),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isUnlocked ? MyColor.greenP.withValues(alpha: 0.1) : MyColor.redCancelTextColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: widget.isUnlocked ? MyColor.greenP : MyColor.redCancelTextColor, width: .5),
                      ),
                      child: Text(
                        widget.isUnlocked ? "Unlocked".tr : "Locked".tr,
                        style: interRegularDefault.copyWith(color: widget.isUnlocked ? MyColor.greenP : MyColor.redCancelTextColor),
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: widget.onTap,
                      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 32,
                        width: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), shape: BoxShape.circle),
                        child: Icon(widget.isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: MyColor.colorBlack, size: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ExpandedSection(
              expand: widget.isOpen,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  buildRow(
                    title: MyStrings.discountOnMaintenanceAmount,
                    value: controller.lockBadges[widget.index].discountMaintenanceCost ?? "null",
                  ),
                  buildRow(
                    title: MyStrings.discountOnPlanPrice,
                    value: controller.lockBadges[widget.index].planPriceDiscount ?? "null",
                    //    value: controller.unlockBadges[widget.index].planPriceDiscount == "0.00" ? "No".tr : "${controller.unlockBadges[widget.index].planPriceDiscount}%",
                  ),
                  buildRow(
                    title: MyStrings.increaseEarningBoost,
                    value: controller.lockBadges[widget.index].earningBoost ?? "null",
                  ),
                  buildRow(
                    title: MyStrings.enhanceReferralBonus,
                    value: controller.lockBadges[widget.index].referralBonusBoost ?? "null",
                    isDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildRow({required String title, required String value, bool isDivider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(title.tr, style: interLightDefault.copyWith(), maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            Expanded(
              flex: 1,
              child: Text(
                value == "0.00"
                    ? "No".tr
                    : value == "null"
                        ? "Prev Level".tr
                        : "${MyConverter.formatNumber(value)}%",
                style: interRegularDefault.copyWith(color: MyColor.bodyTextColor),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        if (isDivider) CustomDivider(),
      ],
    );
  }
}
