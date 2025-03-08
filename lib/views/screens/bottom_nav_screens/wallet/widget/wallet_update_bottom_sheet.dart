import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/wallet/wallet_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/text-field/custom_text_field.dart';

class WalletUpdateBottomSheet {
  static void bottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: MyColor.transparentColor,
        context: context,
        builder: (context) => GetBuilder<WalletController>(builder: (controller) {
              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate,
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
                        Text("${controller.walletList[index].miner?.coinCode ?? ""} ${MyStrings.wallet}", style: interRegularLarge.copyWith(color: MyColor.colorBlack)),
                        const SizedBox(height: Dimensions.space5),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(text: "${MyStrings.balance}: ", style: interRegularSmall.copyWith(color: MyColor.colorGrey)),
                            TextSpan(
                                text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.walletList[index].balance ?? "")} "
                                    "${controller.walletList[index].miner?.coinCode ?? ""}",
                                style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
                          ]),
                        ),
                        const CustomDivider(space: Dimensions.space15),
                        CustomTextField(
                          needLabel: false,
                          needOutlineBorder: true,
                          labelText: MyStrings.address,
                          hintText: MyStrings.enterYourAddress,
                          textInputType: TextInputType.text,
                          controller: controller.walletAddressController,
                          onChanged: (value) {
                            return;
                          },
                        ),
                        const SizedBox(height: Dimensions.space25),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                press: () {
                                  String? id = controller.walletList[index].id != null ? controller.walletList[index].id.toString() : '';
                                  controller.updateWallet(id);
                                },
                                text: MyStrings.updateWallet,
                                color: MyColor.primaryColor,
                                textColor: Colors.white,
                              )
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
}
