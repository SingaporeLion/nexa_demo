import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class ForgetPasswordController extends GetxController{
  
  LoginRepo loginRepo;

  ForgetPasswordController({required this.loginRepo});

  bool submitLoading = false;
  bool isLoading = false;
  TextEditingController emailOrUsernameController = TextEditingController();
  
  void submitForgetPassCode() async {
    String input = emailOrUsernameController.text;

    if(input.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.enterYourEmail]);
      return;
    }

    submitLoading = true;
    update();
    String type = input.contains('@') ? 'email' : 'username';
    String responseEmail = await loginRepo.forgetPassword(type, input);
    if(responseEmail.isNotEmpty){
      emailOrUsernameController.text = '';
      Get.toNamed(RouteHelper.passVerifyScreen,arguments: responseEmail);
    }

    submitLoading = false;
    update();

  }

}


