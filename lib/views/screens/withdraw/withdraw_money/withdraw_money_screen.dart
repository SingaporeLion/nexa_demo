import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/withdraw/withdraw_money_controller.dart';
import 'package:nexa/data/repo/withdraw_repo/withdraw_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/animated_widget/expanded_widget.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/screens/withdraw/withdraw_money/widget/withdraw_money_bottom_sheet.dart';

class WithdrawMoneyScreen extends StatefulWidget {
  const WithdrawMoneyScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawMoneyScreen> createState() => _WithdrawMoneyScreenState();
}

class _WithdrawMoneyScreenState extends State<WithdrawMoneyScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawMoneyController(withdrawRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawMoneyController>(
      builder: (controller) => Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: AppBar(
            backgroundColor: MyColor.primaryColor,
            title: Text(MyStrings.withdrawMoney, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, size: 20, color: MyColor.colorWhite),
            ),
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : controller.methodList.isEmpty
                  ? const Center(
                      child: NoDataFound(),
                    )
                  : SingleChildScrollView(
                      padding: Dimensions.screenPaddingHV,
                      physics: const BouncingScrollPhysics(),
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: controller.methodList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                        itemBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                          decoration: BoxDecoration(
                            color: MyColor.colorWhite,
                            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${controller.methodList[index].miner?.coinCode ?? ""} ${MyStrings.wallet}", style: interRegularSmall.copyWith(color: MyColor.labelTextColor, fontSize: Dimensions.fontDefault)),
                                      const SizedBox(height: Dimensions.space5),
                                      Row(
                                        children: [
                                          Text(
                                              "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.methodList[index].balance ?? "", precision: 8)} "
                                              "${controller.methodList[index].miner?.coinCode ?? ""}",
                                              style: interRegularLarge.copyWith(fontWeight: FontWeight.w500, color: MyColor.colorBlack)),
                                        ],
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (controller.selectedIndex == index) {
                                        controller.changeIndex(-1);
                                      } else {
                                        controller.changeIndex(index);
                                      }
                                    },
                                    icon: Icon(index == controller.selectedIndex ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: MyColor.colorGrey, size: 25),
                                  )
                                ],
                              ),
                              ExpandedSection(
                                expand: index == controller.selectedIndex,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomDivider(space: Dimensions.space15),
                                    Row(
                                      children: [
                                        Image.asset(MyImages.checkMark, height: 15, width: 15),
                                        const SizedBox(width: Dimensions.space10),
                                        Expanded(
                                            child: Text(
                                          '${MyStrings.address}: ${controller.methodList[index].wallet ?? ""}',
                                          style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                          maxLines: 2,
                                        )),
                                      ],
                                    ),
                                    const CustomDivider(space: Dimensions.space15),
                                    Row(
                                      children: [
                                        Image.asset(MyImages.checkMark, height: 15, width: 15),
                                        const SizedBox(width: Dimensions.space10),
                                        Expanded(
                                          child: Text(
                                            "${MyStrings.minLimit}: ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.methodList[index].miner?.minWithdrawLimit ?? "", precision: 8)} ${controller.methodList[index].miner?.coinCode ?? ""}",
                                            style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const CustomDivider(space: Dimensions.space15),
                                    Row(
                                      children: [
                                        Image.asset(MyImages.checkMark, height: 15, width: 15),
                                        const SizedBox(width: Dimensions.space10),
                                        Expanded(
                                          child: Text(
                                            "${MyStrings.maxLimit}: ${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.methodList[index].miner?.maxWithdrawLimit ?? "", precision: 8)} "
                                            "${controller.methodList[index].miner?.coinCode ?? ""}",
                                            style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: Dimensions.space35),
                                    RoundedButton(
                                      press: () {
                                        WithdrawMoneyBottomSheet.bottomSheet(context, controller, index);
                                      },
                                      text: MyStrings.withdrawNow,
                                      textColor: MyColor.colorWhite,
                                      color: MyColor.primaryColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
    );
  }
}
