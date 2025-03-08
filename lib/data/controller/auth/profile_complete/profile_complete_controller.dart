import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/country_model/country_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/profile/profile_complete/profile_complete_post_model.dart';
import 'package:nexa/data/model/profile/profile_complete/profile_complete_response_model.dart';
import 'package:nexa/data/model/user/user.dart';
import 'package:nexa/data/repo/auth/profile_complete/profile_complete_repo.dart';
import 'package:nexa/environment.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class ProfileCompleteController extends GetxController {

  ProfileCompleteRepo profileRepo;


  ProfileCompleteController({required this.profileRepo});

  bool isLoading = false;
  String? countryName;
  String? countryCode;
  String? mobileCode;
  String? userName;
  String? phoneNo;

    String emailData = '';
  String countryData = '';
  String countryCodeData = '';
  String phoneCodeData = '';
  String phoneData = '';
  
  TextEditingController userNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode mobileNoFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();


 initialData() async {
    await getCountryData();
  }


  bool submitLoading=false;
  updateProfile()async{

    String username = userNameController.text.toString();
    String mobileNumber = mobileController.text.toString();
    String address = addressController.text.toString();
    String city = cityController.text.toString();
    String zip = zipCodeController.text.toString();
    String state = stateController.text.toString();

    
    submitLoading = true;
    update();



  


    ProfileCompletePostModel model = ProfileCompletePostModel(
      username: username,
      countryName: countryName ?? "",
      countryCode: countryCode ?? "",
      mobileNumber: mobileNumber,
      mobileCode: mobileCode ?? "",
      address: address,
      state: state,
      zip: zip,
      city: city,
      image: null,
    );
    ResponseModel responseModel = await profileRepo.completeProfile(model);

    if (responseModel.statusCode == 200) {
      ProfileCompleteResponseModel model = ProfileCompleteResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
          print("this is response>>>>>>>>>>>>${responseModel.responseJson}");
        checkAndGotoNextStep(model.data?.user);
        print("this is user>>>>>>>>>>>>${model.data?.user}");
      } else {
        CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.requestFail]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }
  void checkAndGotoNextStep(User? user) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userIdKey, user?.id.toString() ?? '-1');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, user?.email ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, user?.mobile ?? '');
    await profileRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, user?.username ?? '');

    if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerifyScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerifyScreen);
    } else if (isTwoFactorEnable) {
      Get.offAndToNamed(RouteHelper.twoFactorScreen);
    } else {
      await profileRepo.updateDeviceToken();
      Get.offAndToNamed(RouteHelper.homeScreen);
    }
  }

  
  TextEditingController searchCountryController = TextEditingController();
  bool countryLoading = true;
  List<Countries> countryList = [];
  List<Countries> filteredCountries = [];

  String dialCode = Environment.defaultPhoneCode;
  void updateMobilecode(String code) {
    dialCode = code;
    update();
  }

  Future<dynamic> getCountryData() async {
    ResponseModel mainResponse = await profileRepo.getCountryList();

    if (mainResponse.statusCode == 200) {
      CountryModel model = CountryModel.fromJson(jsonDecode(mainResponse.responseJson));
      List<Countries>? tempList = model.data?.countries;

      if (tempList != null && tempList.isNotEmpty) {
        countryList.addAll(tempList);
        filteredCountries.addAll(tempList);
      }
      var selectDefCountry = tempList!.firstWhere(
        (country) => country.countryCode!.toLowerCase() == Environment.defaultCountryCode.toLowerCase(),
        orElse: () => Countries(),
      );
      if (selectDefCountry.dialCode != null) {
        selectCountryData(selectDefCountry);
        setCountryNameAndCode(selectDefCountry.country.toString(), selectDefCountry.countryCode.toString(), selectDefCountry.dialCode.toString());
      }
      countryLoading = false;
      isLoading = false;
      update();
    } else {
      CustomSnackBar.error(errorList: [mainResponse.message]);

      countryLoading = false;

      isLoading = false;
      update();
      return;
    }
  }

  setCountryNameAndCode(String cName, String countryCode, String mobileCode) {
    countryName = cName;
    this.countryCode = countryCode;
    this.mobileCode = mobileCode;
    update();
  }

  Countries selectedCountryData = Countries();
  selectCountryData(Countries value) {
    selectedCountryData = value;
    update();
  }


}
