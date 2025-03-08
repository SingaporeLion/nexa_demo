import 'dart:convert';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/messages.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/controller/localization/localization_controller.dart';
import 'package:nexa/data/model/general_setting/general_settings_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/repo/auth/general_setting_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class SplashController extends GetxController {
  GeneralSettingRepo repo;
  LocalizationController localizationController;
  SplashController({required this.repo, required this.localizationController});

  gotoNext() async {
    await loadLanguage();
    bool isRemember = repo.apiClient.sharedPreferences.getBool(SharedPreferenceHelper.rememberMeKey) ?? false;
    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == "success") {
        repo.apiClient.storeGeneralSetting(model);
        checkAndGo(isRemember);
      } else {
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: [response.message], msg: [], isError: true);
    }
  }

  void checkAndGo(bool isRemember) {
    if (repo.apiClient.getFirstTimeAppOpeningStatus() == false) {
      Get.toNamed(RouteHelper.onboardScreen);
    } else {
      if (isRemember) {
        Get.offAndToNamed(RouteHelper.homeScreen);
      } else {
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAndToNamed(RouteHelper.loginScreen);
        });
      }
    }
  }

  Future<void> loadLanguage() async {
    localizationController.loadCurrentLanguage();
    String languageCode = localizationController.locale.languageCode;

    ResponseModel response = await repo.getLanguage(languageCode);
    if (response.statusCode == 200) {
      // try {
      Map<String, Map<String, String>> language = {};
      var resJson = jsonDecode(response.responseJson);
      saveLanguageList(response.responseJson);
      var value = resJson['data']['file'].toString() == '[]' ? {} : resJson['data']['file'];
      Map<String, String> json = {};
      value.forEach((key, value) {
        json[key] = value.toString();
      });
      language['${localizationController.locale.languageCode}_${localizationController.locale.countryCode}'] = json;
      Get.addTranslations(Messages(languages: language).keys);
      // } catch (e) {
      //   CustomSnackBar.error(errorList: [e.toString()]);
      // }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
  }

  void saveLanguageList(String languageJson) async {
    await repo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.languageListKey, languageJson);
    return;
  }
}
