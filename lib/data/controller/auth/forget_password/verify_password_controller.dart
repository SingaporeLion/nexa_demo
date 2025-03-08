import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/auth/verification/email_verification_model.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class VerifyPasswordController extends GetxController{
  LoginRepo loginRepo;


  List<String> errors = [];
  String email='';
  String password='';
  String confirmPassword='';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;
  String currentText = "";

  VerifyPasswordController({required this.loginRepo});


  bool isResendLoading=false;
  void resendForgetPassCode() async {
    isResendLoading=true;
    update();
    String value = email;
    String type = 'email';
    await loginRepo.forgetPassword(type, value);
    isResendLoading=false;
    update();
  }

  bool verifyLoading=false;

  void verifyForgetPasswordCode(String value) async{
    if(value.isNotEmpty){
      verifyLoading=true;
      update();
      EmailVerificationModel model= await loginRepo.verifyForgetPassCode(value);

      if(model.status=='success'){
        verifyLoading=false;
        Get.offAndToNamed(RouteHelper.resetPasswordScreen,arguments: [email,value]);
      }else{
        verifyLoading=false;
        update();
        List<String>errorList=[MyStrings.verificationFailed];
        CustomSnackBar.error(errorList: model.message?.error??errorList);
      }
    }
  }

  clearAllData(){
    isLoading = false;
    currentText = '';
  }
}


