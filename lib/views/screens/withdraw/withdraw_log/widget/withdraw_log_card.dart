import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/date_converter.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/controller/withdraw/withdraw_controller.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:nexa/views/screens/withdraw/withdraw_log/widget/withdraw_log_bottom_sheet.dart';
import 'package:nexa/views/screens/withdraw/withdraw_log/widget/withdraw_status_btn.dart';

class WithdrawLogCard extends StatelessWidget {
  final int index;
  const WithdrawLogCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
        decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SmallText(text: MyStrings.trx, textColor: MyColor.colorGrey),
                    const SizedBox(height: Dimensions.space5),
                    DefaultText(
                      text: controller.withdrawList[index].trx ?? "",
                      textColor: MyColor.colorBlack,
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    WithdrawLogBottomSheet.bottomSheet(context, index);
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), shape: BoxShape.circle),
                    child: Image.asset(MyImages.dotMenu, color: MyColor.colorBlack, height: 12.5, width: 12.5),
                  ),
                )
              ],
            ),
            const CustomDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SmallText(text: MyStrings.amount, textColor: MyColor.colorGrey),
                    const SizedBox(height: Dimensions.space5),
                    DefaultText(
                      text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.withdrawList[index].amount ?? "")} ${controller.withdrawList[index].currency}",
                      textColor: MyColor.colorBlack,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SmallText(text: MyStrings.date, textColor: MyColor.colorGrey),
                    const SizedBox(height: Dimensions.space5),
                    DefaultText(
                      text: DateConverter.isoStringToLocalDateOnly(controller.withdrawList[index].createdAt ?? ""),
                      textColor: MyColor.colorBlack,
                    )
                  ],
                ),
              ],
            ),
            const CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SmallText(text: MyStrings.wallet, textColor: MyColor.colorGrey),
                      const SizedBox(height: Dimensions.space5),
                      DefaultText(
                        text: controller.withdrawList[index].userCoinBalance?.wallet ?? "",
                        textColor: MyColor.colorBlack,
                      )
                    ],
                  ),
                ),
                WithdrawStatusBtn(status: controller.withdrawList[index].status ?? '')
              ],
            )
          ],
        ),
      ),
    );
  }
}
