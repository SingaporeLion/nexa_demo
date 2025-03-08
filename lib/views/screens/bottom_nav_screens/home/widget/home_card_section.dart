import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/controller/bottom_nav/home/home_controller.dart';
import 'package:nexa/views/screens/bottom_nav_screens/home/components/miner_item_card.dart';

class HomeCardSection extends StatefulWidget {

  const HomeCardSection({Key? key}) : super(key: key);

  @override
  State<HomeCardSection> createState() => _HomeCardSectionState();
}

class _HomeCardSectionState extends State<HomeCardSection> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeController>(
      builder: (controller) => SizedBox(
        height: 95,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MinerCardItem(image: MyImages.balance, title: '${MyStrings.balance}              ', data: controller.balance),
              const SizedBox(width: Dimensions.space10),
              MinerCardItem(image: MyImages.reward, title: MyStrings.referralBonus, data: controller.referralBonus),
              const SizedBox(width: Dimensions.space10),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                itemCount: controller.minersList.length,
                separatorBuilder: (context, index) => const SizedBox(width: Dimensions.space10),
                itemBuilder: (context, index) => MinerCardItem(
                  isNetWorkImage: true,
                  image: "${UrlContainer.baseUrl}${controller.imagePath}${controller.minersList[index].coinImage}",
                  title: "${controller.minersList[index].coinCode ?? " "} ${MyStrings.wallet}",
                  data: "${MyConverter.twoDecimalPlaceFixedWithoutRounding(controller.minersList[index].userCoinBalances?.balance ?? "0",precision: 8)} ${controller.minersList[index].coinCode ?? " "}"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
