import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/plan/buy_plan/buy_plan_controller.dart';
import 'package:nexa/data/repo/plan/buy_plan/buy_plan_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/components/text/default_text.dart';

import 'widget/buy_plan_bottom_sheet.dart';
import 'widget/plan_card.dart';

class MiningPlanScreen extends StatefulWidget {
  const MiningPlanScreen({Key? key}) : super(key: key);

  @override
  State<MiningPlanScreen> createState() => _MiningPlanScreenState();
}

class _MiningPlanScreenState extends State<MiningPlanScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(BuyPlanRepo(apiClient: Get.find()));
    final controller = Get.put(BuyPlanController(buyPlanRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadBuyPlanData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyPlanController>(
      builder: (controller) => Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: MyColor.primaryColor,
            title: Text(MyStrings.plan, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20),
            ),
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : controller.walletList.isEmpty
                  ? const Center(child: NoDataFound())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          padding: Dimensions.screenPaddingHV,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              spacing: 10,
                              children: List.generate(
                                  controller.walletList.length,
                                  (index) => InkWell(
                                        onTap: () {
                                          controller.changeWallet(index);
                                        },
                                        customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space20, vertical: Dimensions.space10),
                                          // margin: const EdgeInsets.only(right: Dimensions.space15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(color: index == controller.index ? MyColor.primaryColor : MyColor.colorWhite, borderRadius: BorderRadius.circular(20)),
                                          child: DefaultText(
                                            text: controller.walletList[index].name ?? "",
                                            textColor: index == controller.index ? MyColor.colorWhite : MyColor.colorBlack,
                                          ),
                                        ),
                                      ))),
                        ),
                        Expanded(
                            child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: controller.planList.length,
                          separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                            child: PlanCard(
                              index: index,
                              title: controller.planList[index].title ?? "",
                              amount: controller.planList[index].price ?? "",
                              currency: controller.currency,
                              validationTime: "${controller.planList[index].period} "
                                  "${controller.planList[index].periodUnit == "2" ? MyStrings.years : controller.planList[index].periodUnit == "1" ? MyStrings.months : MyStrings.days}",
                              features: controller.planList[index].features ?? [],
                              onPressed: () {
                                BuyPlanBottomSheet.bottomSheet(context, index);
                              },
                            ),
                          ),
                        ))
                      ],
                    )),
    );
  }
}
