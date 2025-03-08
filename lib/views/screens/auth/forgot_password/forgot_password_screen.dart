import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/auth_components/auth_layout.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:nexa/views/screens/auth/forgot_password/widget/forgot_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(ForgetPasswordController(loginRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: const CustomAppBar(
            isShowBackBtn: true,
            title: MyStrings.forgotPassword,
            bgColor: MyColor.primaryColor,
          ),
          body: GetBuilder<ForgetPasswordController>(
            builder: (controller) => AuthLayout(
              isLanguageShow: false,
              bottomSpace: Dimensions.space50 * 4.2,
              imageUrl: MyImages.resetPassImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    MyStrings.forgotPassword.tr,
                    textAlign: TextAlign.center,
                    style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600, color: MyColor.primaryColor),
                  ),
                  const SizedBox(height: Dimensions.space3),
                  Text(
                    MyStrings.forgotPasswordSubtitle.tr,
                    textAlign: TextAlign.center,
                    style: interLightDefault.copyWith(color: MyColor.bodyTextColor),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  const ForgotPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
