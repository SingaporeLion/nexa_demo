import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/authorization/authorization_response_model.dart';
import 'package:nexa/data/model/general_setting/general_settings_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetxService {
  SharedPreferences sharedPreferences;
  ApiClient({required this.sharedPreferences});

  Future<ResponseModel> request(
    String uri,
    String method,
    Map<String, dynamic>? params, {
    bool passHeader = false,
    bool isOnlyAcceptType = false,
  }) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == Method.postMethod) {
        if (passHeader) {
          initToken();
          if (isOnlyAcceptType) {
            response = await http.post(url, body: params, headers: {
              "Accept": "application/json",
            });
          } else {
            response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
          }
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.postMethod) {
        if (passHeader) {
          initToken();

          response = await http.post(url, body: params, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.post(url, body: params);
        }
      } else if (method == Method.deleteMethod) {
        response = await http.delete(url);
      } else if (method == Method.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {"Accept": "application/json", "Authorization": "$tokenType $token"});
        } else {
          response = await http.get(
            url,
          );
        }
      }

      print('url--------------${uri.toString()}');
      print('params-----------${params.toString()}');
      print('status-----------${response.statusCode}');
      print('body-------------${response.body.toString()}');
      print('token------------$token');

      if (response.statusCode == 200) {
        try {
          AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(response.body));
          print("object22222 ${model.remark}");
          if (model.remark == 'profile_incomplete') {
            Get.toNamed(RouteHelper.profileCompleteScreen);
          } else if (model.remark == 'kyc_verification') {
            Get.offAndToNamed(RouteHelper.kycScreen);
          } else if (model.remark == 'unauthenticated') {
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(RouteHelper.loginScreen);
          } else if (model.remark == "unverified") {
            checkAndGotoNextStep(model);
          }
        } catch (e) {
          e.toString();
        }

        return ResponseModel(true, 'Success', 200, response.body);
      } else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        Get.offAllNamed(RouteHelper.loginScreen);
        return ResponseModel(false, MyStrings.unAuthorized.tr, 401, response.body);
      } else if (response.statusCode == 500) {
        return ResponseModel(false, MyStrings.serverError.tr, 500, response.body);
      } else {
        return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, response.body);
      }
    } on SocketException {
      return ResponseModel(false, MyStrings.noInternet.tr, 503, '');
    } on FormatException {
      return ResponseModel(false, MyStrings.badResponseMsg.tr, 400, '');
    } catch (e) {
      return ResponseModel(false, MyStrings.somethingWentWrong.tr, 499, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t = sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType = sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }

  storeGeneralSetting(GeneralSettingResponseModel model) {
    String json = jsonEncode(model.toJson());
    sharedPreferences.setString(SharedPreferenceHelper.generalSettingKey, json);
    getGSData();
  }

  GeneralSettingResponseModel getGSData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    return model;
  }

  String getCurrencyOrUsername({bool isCurrency = true, bool isSymbol = false}) {
    if (isCurrency) {
      String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
      String currency = isSymbol ? model.data?.generalSetting?.curSym ?? '' : model.data?.generalSetting?.curText ?? '';
      return currency;
    } else {
      String username = sharedPreferences.getString(SharedPreferenceHelper.userNameKey) ?? '';
      return username;
    }
  }

  String getUserEmail() {
    String email = sharedPreferences.getString(SharedPreferenceHelper.userEmailKey) ?? '';
    return email;
  }

  bool getPasswordStrengthStatus() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    bool checkPasswordStrength = model.data?.generalSetting?.securePassword.toString() == '0' ? false : true;
    return checkPasswordStrength;
  }

  String getTemplateName() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    String templateName = model.data?.generalSetting?.activeTemplate ?? '';
    return templateName;
  }

  storeListToSF(String stringKey, List<String> stringVal) async {
    sharedPreferences.setStringList(stringKey, stringVal);
  }

  storeStringToSF(String stringKey, String stringVal) async {
    sharedPreferences.setString(stringKey, stringVal);
  }

  storeIntToSF(String intKey, int intVal) async {
    sharedPreferences.setInt(intKey, intVal);
  }

  storeDoubleToSF(String doubleKey, double doubleVal) async {
    sharedPreferences.setDouble(doubleKey, doubleVal);
  }

  storeBoolToSF(String boolKey, bool boolVal) async {
    sharedPreferences.setBool(boolKey, boolVal);
  }

  Future<List<String>?> getListValuesSF(String stringKey) async {
    return sharedPreferences.getStringList(stringKey);
  }

  Future<String> getStringValuesSF(String stringKey) async {
    return sharedPreferences.getString(stringKey) ?? "";
  }

  Future<bool> getBoolValuesSF(String boolKey) async {
    return sharedPreferences.getBool(boolKey) ?? false;
  }

  Future<void> clearValueFromSF(String key) async {
    sharedPreferences.remove(key);
  }

  SocialiteCredentials getSocialCredentialsConfigData() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    SocialiteCredentials social = model.data?.generalSetting?.socialiteCredentials ?? SocialiteCredentials();
    return social;
  }

  bool getSocialCredentialsEnabledAll() {
    return getSocialCredentialsConfigData().google?.status == '1' && getSocialCredentialsConfigData().linkedin?.status == '1' && getSocialCredentialsConfigData().facebook?.status == '1';
  }

  bool isSocialAnyOfSocialLoginOptionEnable() {
    return getSocialCredentialsConfigData().google?.status == '1' ||  getSocialCredentialsConfigData().linkedin?.status == '1' || getSocialCredentialsConfigData().facebook?.status == '1';
  }

  String getSocialCredentialsRedirectUrl() {
    String pre = sharedPreferences.getString(SharedPreferenceHelper.generalSettingKey) ?? '';
    GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(pre));
    String redirect = model.data?.socialLoginRedirect ?? "";
    return redirect;
  }
   storeAppOpeningStatus(bool status) {
    sharedPreferences.setBool(SharedPreferenceHelper.appOpeningStatus, status);
  }

  
  bool getFirstTimeAppOpeningStatus() {
    bool status = sharedPreferences.getBool(SharedPreferenceHelper.appOpeningStatus) ?? false;
    return status;
  }

  void checkAndGotoNextStep(AuthorizationResponseModel responseModel) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    bool isProfileCompleteEnable = responseModel.data?.user?.profileComplete == '0' ? true : false;

    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerifyScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerifyScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(
        RouteHelper.twoFactorScreen,
      );
    } else {
      Get.offAndToNamed(RouteHelper.homeScreen);
    }
  }
}
