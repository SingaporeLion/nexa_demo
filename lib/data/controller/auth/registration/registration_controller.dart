import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/auth/error_model.dart';
import 'package:nexa/data/model/auth/registration_response_model.dart';
import 'package:nexa/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:nexa/data/model/general_setting/general_settings_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/repo/auth/general_setting_repo.dart';
import 'package:nexa/data/repo/auth/registration/registration_repo.dart';
import 'package:nexa/views/components/packages/signin_with_linkdin/signin_with_linkedin.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  RegistrationRepo registrationRepo;
  GeneralSettingRepo generalSettingRepo;

  RegistrationController({required this.registrationRepo, required this.generalSettingRepo});

  final FocusNode firstnameFocusNode = FocusNode();
  final FocusNode lastnameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final TextEditingController referralCodeController = TextEditingController();

  bool isLoading = true;
  bool agreeTC = false;

  GeneralSettingResponseModel generalSettingsResponseModel = GeneralSettingResponseModel();

  //it will come from general setting api
  bool checkPasswordStrength = false;
  bool needAgree = true;

  bool submitLoading = false;

  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? confirmPassword;

  registerUser() async {
    submitLoading = true;
    update();

    SignUpModel signUpModel = getUserData();
    ResponseModel response = await registrationRepo.registerUser(signUpModel);

    if (response.statusCode == 200) {
      RegistrationResponseModel registrationModel = RegistrationResponseModel.fromJson(jsonDecode(response.responseJson));
      if (registrationModel.status.toString().toLowerCase() == "success") {
        CustomSnackBar.success(
          successList: registrationModel.message?.success ?? [MyStrings.requestSuccess],
        );
        await checkAndGotoNextStep(registrationModel);
      } else {
        CustomSnackBar.error(
          errorList: registrationModel.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [response.message]);
    }
    submitLoading = false;
    update();
  }

  updateAgreeTC() {
    agreeTC = !agreeTC;
    update();
  }

  SignUpModel getUserData() {
     String referenceValue = referralCodeController.text.toString().split('=').last;
    SignUpModel model = SignUpModel(
      firstName: firstnameController.text.toString(),
      lastName: lastnameController.text.toString(),
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
      refference: referenceValue.toString(),
      agree: agreeTC ? true : false,
    );

    return model;
  }

  Future<void> checkAndGotoNextStep(RegistrationResponseModel responseModel, {bool isSocialLogin = false}) async {
    bool needEmailVerification = responseModel.data?.user?.ev == "1" ? false : true;
    bool needSmsVerification = responseModel.data?.user?.sv == "1" ? false : true;
    bool isTwoFactorEnable = responseModel.data?.user?.tv == '1' ? false : true;

    SharedPreferences preferences = registrationRepo.apiClient.sharedPreferences;
    await preferences.setString(SharedPreferenceHelper.userIdKey, responseModel.data?.user?.id.toString() ?? '-1');
    await preferences.setString(SharedPreferenceHelper.accessTokenKey, responseModel.data?.accessToken ?? '');
    await preferences.setString(SharedPreferenceHelper.accessTokenType, responseModel.data?.tokenType ?? '');
    await preferences.setString(SharedPreferenceHelper.userEmailKey, responseModel.data?.user?.email ?? '');
    await preferences.setString(SharedPreferenceHelper.userNameKey, responseModel.data?.user?.username ?? '');
    await preferences.setString(SharedPreferenceHelper.userPhoneNumberKey, responseModel.data?.user?.mobile ?? '');

    await registrationRepo.sendUserToken();

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

  void initData() async {
    isLoading = true;
    update();

    ResponseModel response = await generalSettingRepo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(jsonDecode(response.responseJson));
      if (model.status?.toLowerCase() == 'success') {
        generalSettingsResponseModel = model;
        registrationRepo.apiClient.storeGeneralSetting(model);
        if (model.data?.generalSetting?.registration?.toLowerCase() == '0') {
          CustomSnackBar.error(errorList: ['Registration is currently disabled']);
          Get.offAllNamed(RouteHelper.loginScreen);
          return;
        }
      } else {
        String message = MyStrings.somethingWentWrong;
        CustomSnackBar.error(errorList: model.message?.error ?? [message]);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        noInternet = true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }

    needAgree = generalSettingsResponseModel.data?.generalSetting?.agree.toString() == '0' ? false : true;
    checkPasswordStrength = generalSettingsResponseModel.data?.generalSetting?.securePassword.toString() == '0' ? false : true;

    isLoading = false;
    update();
  }

  bool noInternet = false;

  void changeInternetStatus(bool hasInternet) {
    noInternet = false;
    initData();
    update();
  }

  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$');

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return MyStrings.pleaseEnterPassword;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return MyStrings.invalidPassMsg;
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
  }

  List<ErrorModel> passwordValidationRules = [
    ErrorModel(text: MyStrings.hasUpperLetter, hasError: true),
    ErrorModel(text: MyStrings.hasLowerLetter, hasError: true),
    ErrorModel(text: MyStrings.hasDigit, hasError: true),
    ErrorModel(text: MyStrings.hasSpecialChar, hasError: true),
    ErrorModel(text: MyStrings.minSixChar, hasError: true),
  ];

  bool hasPasswordFocus = false;
  void changePasswordFocus(bool hasFocus) {
    hasPasswordFocus = hasFocus;
    update();
  }

  void updateValidationList(String value) {
    passwordValidationRules[0].hasError = value.contains(RegExp(r'[A-Z]')) ? false : true;
    passwordValidationRules[1].hasError = value.contains(RegExp(r'[a-z]')) ? false : true;
    passwordValidationRules[2].hasError = value.contains(RegExp(r'[0-9]')) ? false : true;
    passwordValidationRules[3].hasError = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? false : true;
    passwordValidationRules[4].hasError = value.length >= 6 ? false : true;

    update();
  }

//uncomment below codes to socially login

  bool isLinkedinLoading = false;
  Future<void> signInWithLinkedin(BuildContext context) async {
    try {
      isLinkedinLoading = true;
      update();

      SocialiteCredentials linkedinCredential = registrationRepo.apiClient.getSocialCredentialsConfigData();
      String linkedinCredentialRedirectUrl = "${registrationRepo.apiClient.getSocialCredentialsRedirectUrl()}/linkedin";
      print(linkedinCredentialRedirectUrl);
      print(linkedinCredential.linkedin?.toJson());
      SignInWithLinkedIn.signIn(
        context,
        config: LinkedInConfig(clientId: linkedinCredential.linkedin?.clientId ?? '', clientSecret: linkedinCredential.linkedin?.clientSecret ?? '', scope: ['openid', 'profile', 'email'], redirectUrl: "$linkedinCredentialRedirectUrl"),
        onGetAuthToken: (data) {
          print('Auth token data: ${data.toJson()}');
        },
        onGetUserProfile: (token, user) async {
          print('${token.idToken}-');
          print('LinkedIn User: ${user.toJson()}');

          await socialLoginUser(provider: 'linkedin', accessToken: token.accessToken ?? '');
        },
        onSignInError: (error) {
          print('Error on sign in: $error');
          CustomSnackBar.error(errorList: [error.description!] ?? [MyStrings.loginFailedTryAgain.tr]);
          isLinkedinLoading = false;
          update();
        },
      );
    } catch (e) {
      debugPrint(e.toString());

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //SIGN IN With Google
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isSocialSubmitLoading = false;
  bool isGoogle = false;
  bool isMetamask = false;
  bool isFacebook = false;
  bool isLinkedin = false;

  Future<void> signInWithGoogle() async {
    try {
      isGoogle = true;
      update();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // throw Exception('Google Sign-In canceled by user');
        isGoogle = false;
        update();
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      await socialLoginUser(provider: 'google', accessToken: googleAuth.accessToken ?? '');
    } catch (e) {
      debugPrint(e.toString());

      CustomSnackBar.error(errorList: [e.toString()]);
    }
  }

  //Social Login API PART

  Future socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    isSocialSubmitLoading = true;

    update();

    try {
      ResponseModel responseModel = await registrationRepo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        RegistrationResponseModel regModel = RegistrationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (regModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          update();
          checkAndGotoNextStep(regModel, isSocialLogin: true);
        } else {
          isSocialSubmitLoading = false;
          update();
          CustomSnackBar.error(errorList: regModel.message?.error ?? [MyStrings.loginFailedTryAgain.tr]);
        }
      } else {
        isSocialSubmitLoading = false;
        update();
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print(e.toString());
    }

    isGoogle = false;
    isLinkedin = false;
    isSocialSubmitLoading = false;
    update();
  }

  bool checkSocialAuthActiveOrNot({String provider = 'all'}) {
    if (provider == 'google') {
      return registrationRepo.apiClient.getSocialCredentialsConfigData().google?.status == '1';
    } else if (provider == 'facebook') {
      return registrationRepo.apiClient.getSocialCredentialsConfigData().facebook?.status == '1';
    } else if (provider == 'linkedin') {
      return registrationRepo.apiClient.getSocialCredentialsConfigData().linkedin?.status == '1';
    } else {
      return registrationRepo.apiClient.getSocialCredentialsEnabledAll();
    }
  }
}
