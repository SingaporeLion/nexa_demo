import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/bottom_nav/home/home_controller.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/screens/bottom_nav_screens/home/widget/card_list_item.dart';

class HomeStatusCard extends StatelessWidget {
  const HomeStatusCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(MyStrings.minerTracksInfo, style: interRegularDefault.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: Dimensions.space10),
              Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
                  decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: MyColor.screenBgColor.withValues(alpha: 0.5), shape: BoxShape.circle),
                                  child: Image.asset(MyImages.reject, color: MyColor.colorRed, height: 15, width: 15),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.rejected, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(controller.rejected.padLeft(2, '0'), style: interRegularExtraLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: VerticalDivider(
                              color: MyColor.lineColor.withValues(alpha: 0.3),
                              thickness: 1.00,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: MyColor.screenBgColor.withValues(alpha: 0.5), shape: BoxShape.circle),
                                  child: Image.asset(MyImages.running, color: MyColor.primaryColor, height: 15, width: 15),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(MyStrings.running, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(controller.approved.padLeft(2, '0'), style: interRegularExtraLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const CustomDivider(space: Dimensions.space15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: MyColor.screenBgColor.withValues(alpha: 0.5), shape: BoxShape.circle),
                                  child: Image.asset(
                                    MyImages.pending,
                                    color: Colors.orange,
                                    height: 15,
                                    width: 15,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: Dimensions.space10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(MyStrings.pending, style: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
                                    const SizedBox(height: Dimensions.space5),
                                    Text(controller.pending.padLeft(2, '0'), style: interRegularExtraLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w600)),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                            child: VerticalDivider(
                              color: MyColor.lineColor.withValues(alpha: 0.3),
                              thickness: 1.00,
                            ),
                          ),
                          Expanded(
                              child: CardListItem(
                            image: MyImages.unpaid,
                            title: MyStrings.unPaid,
                            quantity: controller.unpaid.padLeft(2, '0'),
                            alignEnd: true,
                          ))
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
}
