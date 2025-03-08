import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/auth/login/login_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/user/user.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class LoginController extends GetxController {
  LoginRepo loginRepo;

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool remember = false;

  LoginController({required this.loginRepo});

  bool isSubmit = false;
  void loginUser() async {
    isSubmit = true;
    update();

    ResponseModel model = await loginRepo.loginUser(usernameController.text.toString(), passwordController.text.toString());

    if (model.statusCode == 200) {
      LoginResponseModel loginModel = LoginResponseModel.fromJson(jsonDecode(model.responseJson));
      if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
        String accessToken = loginModel.data?.accessToken ?? "";
        String tokenType = loginModel.data?.tokenType ?? "";
        User? user = loginModel.data?.user;
        await RouteHelper.checkUserStatusAndGoToNextStep(user, accessToken: accessToken, tokenType: tokenType, isRemember: remember);
        if (remember) {
          changeRememberMe();
        }
      } else {
        CustomSnackBar.error(errorList: loginModel.message?.error ?? [MyStrings.loginFailedTryAgain]);
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }

    isSubmit = false;
    update();
  }

  void forgetPassword() {
    Get.toNamed(RouteHelper.forgotPasswordScreen);
  }

  changeRememberMe() {
    remember = !remember;
    update();
  }

  void clearData() {
    remember = false;
    isSubmit = false;
    usernameController.text = '';
    passwordController.text = '';
  }
}
