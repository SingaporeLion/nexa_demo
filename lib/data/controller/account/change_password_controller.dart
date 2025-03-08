import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/repo/account/change_password_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class ChangePasswordController extends GetxController  {
  ChangePasswordRepo changePasswordRepo;

  ChangePasswordController({required this.changePasswordRepo});


  String? currentPass, password, confirmPass;

  bool submitLoading = false;

  TextEditingController currentPassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FocusNode currentPassFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();




  Future<void>changePassword() async {
    String currentPass = currentPassController.text.toString();
    String password = passController.text.toString();

    bool error = hasError(currentPass:currentPass, password:password);

    if(error){
      return;
    }

    submitLoading = true;
    update();
    bool b = await changePasswordRepo.changePassword(currentPass, password);

    if(b){
      currentPassController.clear();
      passController.clear();
      confirmPassController.clear();
    }

    submitLoading = false ;
    update();

  }

  bool hasError({required String currentPass, required String password}){
    List<String>error = [];
    if (currentPass.isEmpty) {
      error.add(MyStrings.currentPassEmptyMsg);
    }
    if (password.isEmpty) {
      error.add(MyStrings.newPassEmptyMsg);
    }
    if (!(confirmPassController.text == passController.text)) {
      error.add(MyStrings.passNoMatchMsg);
    }

    if(error.isNotEmpty) {
      CustomSnackBar.showCustomSnackBar(errorList: error, msg: [], isError: true);
      return true;
    }

    return false;

  }

  void clearData() {
    submitLoading = false;
    currentPassController.text='';
    passController.text='';
    confirmPassController.text='';
  }
}
