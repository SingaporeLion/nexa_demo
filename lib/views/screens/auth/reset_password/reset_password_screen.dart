import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:nexa/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/auth_components/auth_layout.dart';
import 'package:nexa/views/screens/auth/reset_password/widget/reset_pass_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient:Get.find()));
    final controller =Get.put(ResetPasswordController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.token = Get.arguments[1];
    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<ForgetPasswordController>().isLoading = false;
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            appBar: const CustomAppBar(title: MyStrings.resetPassword, isShowBackBtn: true, bgColor: MyColor.primaryColor),
            body: GetBuilder<ResetPasswordController>(
              builder: (controller) => AuthLayout(
                bottomSpace: Dimensions.space50 * 1.80,
                imageUrl: MyImages.resetPassImage,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(MyStrings.resetPassword, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: Dimensions.space30),
                      const ResetPasswordForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
