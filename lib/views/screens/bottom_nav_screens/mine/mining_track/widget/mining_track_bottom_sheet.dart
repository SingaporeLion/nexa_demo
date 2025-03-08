import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/date_converter.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/plan/mining_tracks/mining_tracks_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/header_text.dart';
import 'package:nexa/views/components/text/small_text.dart';

class MiningTrackBottomSheet {
  static void bottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) => GetBuilder<MiningTracksController>(
              builder: (controller) => SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                  decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 5,
                          width: 50,
                          decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: Dimensions.space15),
                      HeaderText(text: MyStrings.miningTrackDetails, textStyle: interSemiBoldLarge.copyWith(color: MyColor.colorBlack)),
                      const CustomDivider(space: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.planTitle, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].planDetails?.title ?? "", textColor: MyColor.colorBlack)],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.date, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: DateConverter.isoStringToLocalDateOnly(controller.miningTrackList[index].createdAt ?? ""), textColor: MyColor.colorBlack)],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.amount, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.miningTrackList[index].amount ?? "")} ${controller.currency}", textColor: MyColor.colorBlack)],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.miner, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].planDetails?.miner ?? "", textColor: MyColor.colorBlack)],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.speed, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].planDetails?.speed ?? "", textColor: MyColor.colorBlack)],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.returnDay, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].minReturnPerDay ?? "", textColor: MyColor.colorBlack)],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.totalDays, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].period.toString(), textColor: MyColor.colorBlack)],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [const SmallText(text: MyStrings.remainingDays, textColor: MyColor.colorGrey), const SizedBox(height: Dimensions.space5), DefaultText(text: controller.miningTrackList[index].periodRemain.toString(), textColor: MyColor.colorBlack)],
                            ),
                          )
                        ],
                      ),
                      controller.miningTrackList[index].status == "0"
                          ? Column(
                              children: [
                                const CustomDivider(space: Dimensions.space20),
                                RoundedButton(
                                  press: () {
                                    String orderId = controller.miningTrackList[index].id.toString();
                                    String amount = controller.miningTrackList[index].amount ?? '';
                                    String title = controller.miningTrackList[index].planDetails?.title ?? '';
                                    Get.back();
                                    Get.toNamed(RouteHelper.planPaymentMethodScreen, arguments: [title, amount, orderId]);
                                  },
                                  text: MyStrings.payNow,
                                  textColor: MyColor.colorWhite,
                                  color: MyColor.primaryColor,
                                ),
                                const SizedBox(height: Dimensions.space20)
                              ],
                            )
                          : controller.miningTrackList[index].status == "1"
                              ? const SizedBox(height: Dimensions.space20)
                              : controller.miningTrackList[index].status == "2"
                                  ? const SizedBox(height: Dimensions.space20)
                                  : controller.miningTrackList[index].status == "3"
                                      ? const SizedBox(height: Dimensions.space20)
                                      : const SizedBox(height: Dimensions.space20)
                    ],
                  ),
                ),
              ),
            ));
  }
}
