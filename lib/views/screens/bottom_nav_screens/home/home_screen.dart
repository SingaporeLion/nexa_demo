import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/date_converter.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/bottom_nav/home/home_controller.dart';
import 'package:nexa/data/controller/profile/user_profile_controller.dart';
import 'package:nexa/data/repo/bottom_nav/home/home_repo.dart';
import 'package:nexa/data/repo/profile/user_profile_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/bottom_Nav/bottom_nav.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';
import 'package:nexa/views/components/text/default_text.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:nexa/views/screens/bottom_nav_screens/home/widget/home_status_card.dart';
import 'package:nexa/views/screens/bottom_nav_screens/home/widget/home_top_section.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {

    MyUtils.allScreenUtil();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    Get.put(UserProfileRepo(apiClient: Get.find()));

    final controller = Get.put(HomeController(homeRepo: Get.find()));
    final userController = Get.put(UserProfileController(userProfileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadDashboardData();
      userController.loadProfileInfo();
      controller.minersList.clear();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return  WillPopWidget(
      nextRoute: '',
      child: Container(
        color: MyColor.primaryColor,
        child: SafeArea(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: MyColor.screenBgColor,
            body: GetBuilder<HomeController>(
              builder: (controller) => controller.isLoading ? const CustomLoader(isFullScreen: true,) : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: Dimensions.space20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HomeTopSection(),
                    const SizedBox(height: Dimensions.space20),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                      margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                      decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(MyStrings.referralLink, style: interSemiBoldDefault.copyWith(color: MyColor.colorBlack)),
                          const SizedBox(height: Dimensions.space10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.72,
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                                decoration: BoxDecoration(
                                    color: MyColor.transparentColor,
                                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                                    border: Border.all(color: MyColor.primaryColor, width: 0.5)
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    controller.referralLink.toString(),
                                    style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(width: Dimensions.space15),
                              GestureDetector(
                                onTap: (){
                                  Clipboard.setData(ClipboardData(text: controller.referralLink.toString()));
                                  CustomSnackBar.showCustomSnackBar(errorList: [], msg: [MyStrings.referralLinkCopied], isError: false);
                                },
                                child: const Icon(Icons.copy, color: MyColor.primaryColor, size: 20),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimensions.space20),
                    const HomeStatusCard(),
                    const SizedBox(height: Dimensions.space20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(MyStrings.latestTransaction, style: interRegularDefault.copyWith(fontWeight: FontWeight.w600)),
                          InkWell(
                            onTap: () => Get.toNamed(RouteHelper.transactionScreen),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                              child: Text(MyStrings.viewAll, style: interRegularSmall.copyWith(color: MyColor.primaryColor)),
                            ),
                          )
                        ],
                      )
                    ),
                    const SizedBox(height: Dimensions.space10),
                    controller.transactionList.isEmpty ? const Center(
                      child: NoDataFound(),
                    ) : ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.transactionList.length,
                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                      itemBuilder: (context, index){
                        return  Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
                          padding: const EdgeInsets.all(Dimensions.space15),
                          decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SmallText(text: MyStrings.trxNo, textColor: MyColor.labelTextColor),
                                      const SizedBox(height: Dimensions.space5),
                                      DefaultText(text: controller.transactionList[index].trx ?? "", textColor: MyColor.colorBlack)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SmallText(text: MyStrings.date, textColor: MyColor.labelTextColor),
                                      const SizedBox(height: 8),
                                      DefaultText(text: DateConverter.isoStringToLocalDateOnly(controller.transactionList[index].createdAt ?? ""), textColor: MyColor.colorBlack)
                                    ],
                                  ),
                                ],
                              ),
                              const CustomDivider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SmallText(text: MyStrings.amount, textColor: MyColor.labelTextColor),
                                      const SizedBox(height: Dimensions.space5),
                                      DefaultText(
                                          text: "${controller.transactionList[index].trxType} "
                                              "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].amount.toString())} "
                                              "${controller.transactionList[index].currency??''}",
                                          textColor: controller.changeStatusColor(controller.transactionList[index].trxType.toString(),index)
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const SmallText(text: MyStrings.postBalance, textColor: MyColor.labelTextColor),
                                      const SizedBox(height: Dimensions.space5),
                                      DefaultText(
                                        text:"${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.transactionList[index].postBalance.toString())} "
                                          "${controller.transactionList[index].currency??''}",
                                        textColor: MyColor.colorBlack,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const CustomDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SmallText(text: MyStrings.details, textColor: MyColor.labelTextColor),
                                  const SizedBox(height: Dimensions.space5),
                                  DefaultText(
                                    text: controller.transactionList[index].details ?? "",
                                    textColor: MyColor.colorBlack,
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
          ),
        ),
      ),
    );
  }


}
