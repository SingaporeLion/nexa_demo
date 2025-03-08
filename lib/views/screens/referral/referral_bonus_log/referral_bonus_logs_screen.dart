import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/referral/referral_log_controller.dart';
import 'package:nexa/data/repo/referral/referral_log_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/small_text.dart';

class ReferralBonusLogsScreen extends StatefulWidget {

  const ReferralBonusLogsScreen({Key? key}) : super(key: key);

  @override
  State<ReferralBonusLogsScreen> createState() => _ReferralBonusLogsScreenState();
}

class _ReferralBonusLogsScreenState extends State<ReferralBonusLogsScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<ReferralLogController>().hasNext()){
        Get.find<ReferralLogController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ReferralLogRepo(apiClient: Get.find()));
    final controller = Get.put(ReferralLogController(referralLogRepo: Get.find()));
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
    return Scaffold(
      backgroundColor: MyColor.screenBgColor,
      appBar: AppBar(
        title: Text(MyStrings.referralBonusLogs, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
        backgroundColor: MyColor.primaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, size: 20, color: MyColor.colorWhite),
        ),
        actions: [
          InkWell(
            onTap: () => Get.toNamed(RouteHelper.myReferralScreen),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
              margin: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
              child: const SmallText(text: MyStrings.myReferrals, textColor: MyColor.primaryColor, textAlign: TextAlign.center)
            ),
          )
        ],
      ),
      body: GetBuilder<ReferralLogController>(
        builder: (controller) => controller.isLoading ? const CustomLoader() : controller.referralDataList.isEmpty ? const Center(
          child: NoDataFound(),
        ) : ListView.separated(
            itemCount: controller.referralDataList.length+1,
            padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
            shrinkWrap: true,
            controller: scrollController,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
            itemBuilder: (context, index) {
              if(controller.referralDataList.length==index){
                return controller.hasNext()? const CustomLoader(isPagination: true,) : const SizedBox();
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SmallText(text: MyStrings.user, textColor: MyColor.colorGrey),
                            const SizedBox(height: Dimensions.space5),
                            DefaultText(
                              text: controller.referralDataList[index].referee?.username ?? "",
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SmallText(text: MyStrings.level, textColor: MyColor.colorGrey),
                            const SizedBox(height: Dimensions.space5),
                            DefaultText(
                              text: "${controller.referralDataList[index].level}".padLeft(2, "0"),
                            )
                          ],
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
                              text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.referralDataList[index].amount ?? "")} ${controller.currency}",
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SmallText(text: MyStrings.percent, textColor: MyColor.colorGrey),
                            const SizedBox(height: Dimensions.space5),
                            DefaultText(
                              text: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.referralDataList[index].percent ?? "")}%",
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
