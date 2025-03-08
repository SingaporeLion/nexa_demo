import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/withdraw/withdraw_controller.dart';
import 'package:nexa/data/repo/withdraw_repo/withdraw_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/general_components/no_data_found.dart';
import 'package:nexa/views/screens/withdraw/withdraw_log/widget/withdraw_log_card.dart';
import 'package:nexa/views/screens/withdraw/withdraw_log/widget/withdraw_log_top.dart';

class WithdrawLogScreen extends StatefulWidget {

  const WithdrawLogScreen({Key? key}) : super(key: key);
  @override
  State<WithdrawLogScreen> createState() => _WithdrawLogScreenState();
}

class _WithdrawLogScreenState extends State<WithdrawLogScreen> {

  final ScrollController scrollController = ScrollController();

  void scrollListener(){
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(Get.find<WithdrawController>().hasNext()){
        Get.find<WithdrawController>().loadPaginationData();
      }
    }
  }

  @override
  void initState() {
    MyUtils.makePortraitOnly();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller = Get.put(WithdrawController(withdrawRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    scrollController.dispose();
    MyUtils.makePortraitAndLandscape();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<WithdrawController>(
      builder: (controller) => Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: AppBar(
            title: Text(MyStrings.withdrawHistory, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            backgroundColor: MyColor.primaryColor,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, size: 20, color: MyColor.colorWhite),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.space15),
                child: InkWell(
                  onTap: (){
                    controller.changeSearchStatus();
                  },
                  child: Container(
                    height: 30, width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
                    child: Icon(controller.isSearch ? Icons.clear : Icons.search, color: MyColor.primaryColor, size: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: Dimensions.space15),
                child: InkWell(
                  onTap: () => Get.toNamed(RouteHelper.withdrawMoneyScreen),
                  child: Container(
                    height: 30, width: 30,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: MyColor.colorWhite, shape: BoxShape.circle),
                    child: const Icon(Icons.add, color: MyColor.primaryColor, size: 15),
                  ),
                ),
              )
            ],
          ),
          body: controller.isLoading ? const CustomLoader() : Padding(
            padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
            child: Column(
              children: [
                Visibility(
                  visible: controller.isSearch,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      WithdrawLogTop(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
    
                Expanded(
                  child: controller.withdrawList.isEmpty && controller.filterLoading == false ? const Center(
                    child: NoDataFound(),
                  ) : controller.filterLoading ?
                  const CustomLoader() : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      itemCount: controller.withdrawList.length+1,
                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                      itemBuilder: (context, index) {
                        if(controller.withdrawList.length == index){
                          return controller.hasNext()?const CustomLoader(isPagination: true,) : const SizedBox();
                        }
                        return WithdrawLogCard(index: index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}