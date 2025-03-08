import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/data/model/general_setting/general_settings_response_model.dart';

class OnboardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

  List<String> onboardTitleList = [
    'MineLab-Cloud Crypto Mining Platform',
    'Run your next crypto-mining business flawlessly',
    'currently it\'s 8 Billion industry. Start your Business Today',
  ];


  List<String> onboardSubtitleList = [
    'MineLab-Cloud enables scalable, cost-effective crypto mining via remote data centers.',
    'Effortlessly run your next crypto-mining business with seamless, optimized operations.',
    'Join the \$8 billion industry; start your business today and thrive!',
  ];

  List<String> onboardImageList = [
    MyImages.onboardFirstImage,
    MyImages.onboardSecondImage,
    MyImages.onboardThirdImage,
  ];

  bool isLoading = true;

  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  List<String> onBoardImage = [];
}
