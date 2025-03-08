import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';

class CustomBottomNav extends StatefulWidget {

  final int currentIndex;

  const CustomBottomNav({
    Key? key,
    required this.currentIndex
  }) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {

  var bottomNavIndex = 0;

  List<String> iconList = [MyImages.home, MyImages.wallet, MyImages.miningTracks, MyImages.category];
  final textList = [MyStrings.home, MyStrings.wallets, MyStrings.miningTracks, MyStrings.menu];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
       height: 65,
       elevation: 10,
       itemCount: iconList.length,
       tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconList[index],
                height: 20, width: 20,
                color: isActive ? MyColor.primaryColor : MyColor.colorGrey,
              ),
              const SizedBox(height: Dimensions.space5),
              Text(
                textList[index],
                style: interRegularExtraSmall.copyWith(color: isActive ? MyColor.primaryColor : MyColor.colorGrey)
              )
            ],
          );
       },
       backgroundColor: MyColor.colorWhite,
       gapLocation: GapLocation.none,
       leftCornerRadius: 0,

       rightCornerRadius: 0,
       onTap: (index) {
         _onTap(index);
       },
       activeIndex: bottomNavIndex,
    );
  }
  void _onTap(int index) {
    if (index == 0) {
      if (!(widget.currentIndex == 0)) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      }
    }
    else if (index == 1) {
      if (!(widget.currentIndex == 1)) {
        Get.offAndToNamed(RouteHelper.walletScreen);
      }
    }
    else if (index == 2) {
      if (!(widget.currentIndex == 2)) {
        Get.offAndToNamed(RouteHelper.miningTrackScreen);
      }
    }
    else if (index == 3) {
      if (!(widget.currentIndex == 3)) {
        Get.offAndToNamed(RouteHelper.menuScreen);
      }
    }
  }
}




  


