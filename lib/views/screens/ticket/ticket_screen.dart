import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/date_converter.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/support/support_controller.dart';
import 'package:nexa/data/repo/support/support_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/column_widget/card_column.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/floating_action_button/fab.dart';
import 'package:nexa/views/components/no_data.dart';
import 'package:nexa/views/components/shimmer/match_card_shimmer.dart';

class AllTicketScreen extends StatefulWidget {
  const AllTicketScreen({super.key});

  @override
  State<AllTicketScreen> createState() => _AllTicketScreenState();
}

class _AllTicketScreenState extends State<AllTicketScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<SupportController>().hasNext()) {
        Get.find<SupportController>().getSupportTicket();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiClient: Get.find()));
    final controller = Get.put(SupportController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportController>(builder: (controller) {
      return Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: const CustomAppBar(bgColor: MyColor.primaryColor, title: MyStrings.supportTicket),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          color: MyColor.primaryColor,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  padding: Dimensions.defaultPaddingHV,
                  child: controller.isLoading
                      ? ListView.builder(
                          itemCount: 10,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return const MatchCardShimmer();
                          },
                        )
                      : controller.ticketList.isEmpty
                          ? Center(
                              child: NoDataWidget(
                                text: MyStrings.noTicketFound.toCapitalized(),
                              ),
                            )
                          : ListView.separated(
                              controller: scrollController,
                              itemCount: controller.ticketList.length + 1,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                              itemBuilder: (context, index) {
                                if (controller.ticketList.length == index) {
                                  return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                                }
                                return GestureDetector(
                                  onTap: () {
                                    String id = controller.ticketList[index].ticket ?? '-1';
                                    String subject = controller.ticketList[index].subject ?? '';
                                    Get.toNamed(RouteHelper.ticketDetailsScreen, arguments: [id, subject]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space25),
                                    decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(Dimensions.mediumRadius), border: Border.all(color: MyColor.cardBorderColor, width: 1)),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.only(end: Dimensions.space10),
                                                child: Column(
                                                  children: [
                                                    CardColumn(
                                                      header: "[${MyStrings.ticket.tr}#${controller.ticketList[index].ticket}] ${controller.ticketList[index].subject}",
                                                      body: "${controller.ticketList[index].lastReply}",
                                                      space: 5,
                                                      headerTextDecoration: interRegularDefault.copyWith(
                                                        color: Theme.of(context).textTheme.titleLarge?.color,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                      bodyTextDecoration: interRegularDefault.copyWith(
                                                        color: MyColor.ticketDetails,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: controller.getStatusColor(controller.ticketList[index].status ?? "0").withValues(alpha: 0.2),
                                                border: Border.all(
                                                  color: controller.getStatusColor(
                                                    controller.ticketList[index].status ?? "0",
                                                  ),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Text(
                                                controller.getStatusText(controller.ticketList[index].status ?? '0'),
                                                style: interRegularDefault.copyWith(
                                                  color: controller.getStatusColor(controller.ticketList[index].status ?? "0"),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: Dimensions.space15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true).withValues(alpha: 0.2),
                                                border: Border.all(color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true), width: 1),
                                              ),
                                              child: Text(
                                                controller.getStatus(controller.ticketList[index].priority ?? '1', isPriority: true),
                                                style: interRegularDefault.copyWith(
                                                  color: controller.getStatusColor(controller.ticketList[index].priority ?? "0", isPriority: true),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              DateConverter.getFormatedSubtractTime(controller.ticketList[index].createdAt ?? ''),
                                              style: interRegularDefault.copyWith(fontSize: 10, color: MyColor.ticketDateColor),
                                            ),
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
            ],
          ),
        ),
        floatingActionButton: FAB(
          callback: () {
            Get.toNamed(RouteHelper.newTicketScreen)?.then((value) => {Get.find<SupportController>().getSupportTicket()});
          },
        ),
      );
    });
  }
}
