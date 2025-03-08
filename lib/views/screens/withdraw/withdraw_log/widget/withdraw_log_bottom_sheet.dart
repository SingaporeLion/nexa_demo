import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/withdraw/withdraw_controller.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/small_text.dart';

import 'withdraw_status_btn.dart';

class WithdrawLogBottomSheet {
  static void bottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) => GetBuilder<WithdrawController>(
              builder: (withdrawController) => SingleChildScrollView(
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
                      Text(MyStrings.withdrawDetails, style: interRegularLarge.copyWith(color: MyColor.colorBlack)),
                      const CustomDivider(space: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: MyStrings.transactionNo, textColor: MyColor.colorGrey),
                              const SizedBox(height: Dimensions.space5),
                              DefaultText(
                                text: withdrawController.withdrawList[index].trx ?? "",
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SmallText(text: MyStrings.amount, textColor: MyColor.colorGrey),
                              const SizedBox(height: Dimensions.space5),
                              DefaultText(
                                text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(withdrawController.withdrawList[index].finalAmount ?? "")} ${withdrawController.withdrawList[index].currency}",
                                textColor: MyColor.colorBlack,
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: Dimensions.space15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SmallText(text: MyStrings.balance, textColor: MyColor.colorGrey),
                              const SizedBox(height: Dimensions.space5),
                              DefaultText(
                                text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(withdrawController.withdrawList[index].userCoinBalance?.balance ?? "")} ${withdrawController.withdrawList[index].currency}",
                                textColor: MyColor.colorBlack,
                              )
                            ],
                          ),
                          WithdrawStatusBtn(status: withdrawController.withdrawList[index].status ?? '')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
