import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/date_converter.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/plan/purchased_plan/purchased_plan_controller.dart';
import 'package:nexa/data/repo/plan/purchased_plan/purchased_plan_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:nexa/views/screens/bottom_nav_screens/mine/mining_history/widget/mining_history_bottom_sheet.dart';

class MiningHistoryScreen extends StatefulWidget {

  const MiningHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MiningHistoryScreen> createState() => _MiningHistoryScreenState();
}

class _MiningHistoryScreenState extends State<MiningHistoryScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<PurchasedPlanController>().hasNext()){
        Get.find<PurchasedPlanController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(PurchasedPlanRepo(apiClient: Get.find()));
    final controller = Get.put(PurchasedPlanController(purchasedPlanRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<PurchasedPlanController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.homeScreen,
        child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            appBar: AppBar(
              title: Text(MyStrings.miningHistory, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
              leading: IconButton(
                onPressed: (){
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back, size: 20, color: MyColor.colorWhite),
              ),
              backgroundColor: MyColor.primaryColor,
              elevation: 0,
              actions: [
                InkWell(
                  onTap: () => Get.toNamed(RouteHelper.miningPlanScreen),
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10),
                      margin: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(MyImages.miningTracks, color: MyColor.primaryColor, height: 20, width: 20),
                          const SizedBox(width: Dimensions.space10),
                          const SmallText(text: MyStrings.startMining, textAlign: TextAlign.center, textColor: MyColor.primaryColor),
                        ],
                      )
                  ),
                )
              ],
            ),
            body: controller.isLoading ? const CustomLoader() : controller.purchasedPlanList.isEmpty ? const Center(
              child: NoDataFound(),
            ) : Padding(
              padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.purchasedPlanList.length+1,
                separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                itemBuilder: (context, index){
                  if(index==controller.purchasedPlanList.length){
                    return controller.hasNext()?const CustomLoader(isPagination: true,)
                        : const SizedBox();
                  }
                  return InkWell(
                    onTap: (){
                      MiningHistoryBottomSheet.bottomSheet(context, index);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space12),
                      decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SmallText(text: MyStrings.planTitle, textColor:MyColor.labelTextColor),
                                  const SizedBox(height: Dimensions.space5),
                                  DefaultText(text: controller.purchasedPlanList[index].planDetails?.title ?? "")
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SmallText(text: MyStrings.purchasedDate, textColor: MyColor.labelTextColor),
                                  const SizedBox(height: Dimensions.space5),
                                  DefaultText(text: DateConverter.isoStringToLocalDateOnly(controller.purchasedPlanList[index].createdAt ?? ""))
                                ],
                              )
                            ],
                          ),
                          const CustomDivider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SmallText(text: MyStrings.amount, textColor: MyColor.labelTextColor),
                                  const SizedBox(height: Dimensions.space5),
                                  DefaultText(text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.purchasedPlanList[index].amount ?? "")} ${controller.currency}")
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: controller.purchasedPlanList[index].status == "0" ? MyColor.lineColor
                                            :controller.purchasedPlanList[index].status == "1" ? MyColor.primaryColor
                                            : controller.purchasedPlanList[index].status == "2" ? Colors.orangeAccent
                                            : controller.purchasedPlanList[index].status == "3" ? Colors.red : MyColor.primaryColor
                                    )
                                ),
                                child: Text(
                                  controller.purchasedPlanList[index].status == "0" ? MyStrings.unPaid
                                      : controller.purchasedPlanList[index].status == "1" ? MyStrings.approved
                                      : controller.purchasedPlanList[index].status == "2" ? MyStrings.pending
                                      : controller.purchasedPlanList[index].status == "3" ? MyStrings.rejected
                                      : "",
                                  textAlign: TextAlign.center,
                                  style: interRegularDefault.copyWith(
                                      color: controller.purchasedPlanList[index].status == "0" ? MyColor.lineColor
                                      : controller.purchasedPlanList[index].status == "1" ? MyColor.primaryColor
                                      : controller.purchasedPlanList[index].status == "2" ? Colors.orangeAccent
                                      : controller.purchasedPlanList[index].status == "3" ? Colors.red : MyColor.primaryColor,
                                      fontSize: Dimensions.fontExtraSmall
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ),
      ),
    );
  }
}
