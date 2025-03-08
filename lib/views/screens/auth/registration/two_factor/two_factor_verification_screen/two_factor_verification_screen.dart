import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/two_factor_controller.dart';
import 'package:nexa/data/repo/auth/two_factor_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/image/custom_svg_picture.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TwoFactorVerificationScreen extends StatefulWidget {
  const TwoFactorVerificationScreen({
    super.key,
  });

  @override
  State<TwoFactorVerificationScreen> createState() => _TwoFactorVerificationScreenState();
}

class _TwoFactorVerificationScreenState extends State<TwoFactorVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TwoFactorRepo(apiClient: Get.find()));
    Get.put(TwoFactorController(repo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: CustomAppBar(
          bgColor: MyColor.primaryColor,
          title: MyStrings.twoFactorAuth.tr,
          fromAuth: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space20),
          child: GetBuilder<TwoFactorController>(
              builder: (controller) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: Dimensions.space20),
                        Container(
                          height: Dimensions.space100,
                          width: Dimensions.space100,
                          padding: const EdgeInsets.all(Dimensions.space15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: MyColor.primaryColor.withValues(alpha: .075), shape: BoxShape.circle),
                          child: Image.asset(MyImages.twoFA, height: 100, width: 100, color: MyColor.primaryColor),
                        ),
                        const SizedBox(height: Dimensions.space50),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                          child: SmallText(textColor: MyColor.colorBlack, text: MyStrings.twoFactorMsg.tr, textAlign: TextAlign.center, textStyle: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                        ),
                        const SizedBox(height: Dimensions.space50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space30),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: interRegularDefault.copyWith(color: MyColor.bodyTextColor),
                            length: 6,
                            textStyle: interRegularDefault.copyWith(color: MyColor.bodyTextColor),
                            obscureText: false,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: false,
                            animationType: AnimationType.fade,
                            pinTheme:
                                PinTheme(shape: PinCodeFieldShape.box, borderWidth: 1, borderRadius: BorderRadius.circular(5), fieldHeight: 40, fieldWidth: 40, inactiveColor: MyColor.colorGrey, inactiveFillColor: MyColor.transparentColor, activeFillColor: MyColor.transparentColor, activeColor: MyColor.primaryColor, selectedFillColor: MyColor.transparentColor, selectedColor: MyColor.primaryColor),
                            cursorColor: MyColor.colorBlack,
                            animationDuration: const Duration(milliseconds: 100),
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            beforeTextPaste: (text) {
                              return true;
                            },
                            onChanged: (value) {
                              setState(() {
                                controller.currentText = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: Dimensions.space30),
                        controller.submitLoading
                            ? const RoundedLoadingBtn()
                            : RoundedButton(
                                press: () {
                                  controller.verify2FACode(controller.currentText);
                                },
                                text: MyStrings.verify.tr,
                              ),
                        const SizedBox(height: Dimensions.space30),
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
