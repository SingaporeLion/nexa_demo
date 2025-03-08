import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/email_verification_controler.dart';
import 'package:nexa/data/controller/profile/user_profile_controller.dart';
import 'package:nexa/data/repo/auth/general_setting_repo.dart';
import 'package:nexa/data/repo/auth/sms_email_verification_repo.dart';
import 'package:nexa/data/repo/profile/user_profile_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/auth_components/auth_layout.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerifyScreen extends StatefulWidget {

  const EmailVerifyScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    Get.put(GeneralSettingRepo(apiClient: Get.find()));
    final controller = Get.put(EmailVerificationController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: const CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            bgColor: MyColor.primaryColor,
            title: MyStrings.emailVerify,
          ),
          body: GetBuilder<EmailVerificationController>(
            builder: (controller) => AuthLayout(
              bottomSpace: Dimensions.space50 * 2.2,
              imageUrl: MyImages.otpImage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    Text(MyStrings.enterOtp, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      MyStrings.verifyPasswordSubText,
                      textAlign: TextAlign.center,
                      style: interRegularDefault.copyWith(color: MyColor.primarySubTitleColor)
                    ),
                    const SizedBox(height: Dimensions.space20),
                    PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: interRegularDefault.copyWith(color: MyColor.primaryColor),
                      length: 6,
                      textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack),
                      obscureText: false,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderWidth: 1,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 40,
                      fieldWidth: 40,
                      inactiveColor:  MyColor.colorGrey,
                      inactiveFillColor: MyColor.transparentColor,
                      activeFillColor: MyColor.transparentColor,
                      activeColor: MyColor.primaryColor,
                      selectedFillColor: MyColor.transparentColor,
                      selectedColor: MyColor.primaryColor
                  ),
                      cursorColor: MyColor.colorBlack,
                      animationDuration:
                      const Duration(milliseconds: 100),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      beforeTextPaste: (text) {
                        return true;
                      },
                      onChanged: (value) {
                        controller.currentText = value;
                      },
                    ),
                    const SizedBox(height: Dimensions.space25),
                    controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
                        text: MyStrings.submit,
                        textColor: MyColor.colorWhite,
                        color: MyColor.primaryColor,
                        press: (){
                          controller.verifyEmail(controller.currentText);
                        }
                    )
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
