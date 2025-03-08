import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/model/achievement/achievement_response_model.dart';
import 'package:nexa/views/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';

class AchievementDetailsBottomSheetBody extends StatelessWidget {
  final LockBadge model;
  const AchievementDetailsBottomSheetBody({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: MyColor.colorGrey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(MyStrings.details.tr, style: interBoldDefault.copyWith()),
              BottomSheetCloseButton(iconColor: MyColor.redCancelTextColor),
            ],
          ),
          SizedBox(height: 20),
          buildRow(title: MyStrings.discountOnMaintenanceAmount, value: "${MyConverter.formatNumber(model.discountMaintenanceCost ?? "0")}%"),
          buildRow(title: MyStrings.discountOnPlanPrice, value: "${MyConverter.formatNumber(model.planPriceDiscount ?? "0")}%"),
          buildRow(title: MyStrings.increaseEarningBoost, value: "${MyConverter.formatNumber(model.earningBoost ?? "0")}%"),
          buildRow(title: MyStrings.enhanceReferralBonus, value: "${MyConverter.formatNumber(model.referralBonusBoost ?? "0")}%", isDivider: false),
        ],
      ),
    );
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
                value == "0.00%" ? "N/A".tr : value,
                style: interRegularDefault.copyWith(fontSize: 18),
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
