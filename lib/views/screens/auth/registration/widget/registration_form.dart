import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/registration/registration_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/text-field/custom_text_field.dart';
import 'package:nexa/views/screens/auth/login/widget/social_login_section.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool isChecked = false;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.firstName,
              hintText: MyStrings.enterFirstName,
              controller: controller.firstnameController,
              focusNode: controller.firstnameFocusNode,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterFirstName;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.lastName,
              hintText: MyStrings.enterLastName,
              controller: controller.lastnameController,
              focusNode: controller.lastnameFocusNode,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterLastName;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.emailAddress,
              hintText: MyStrings.emailAddressHint,
              controller: controller.emailController,
              focusNode: controller.emailFocusNode,
              textInputType: TextInputType.emailAddress,
              onChanged: (value) {},
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return MyStrings.emailAddressHint;
                } else if (!MyStrings.emailValidatorRegExp.hasMatch(value ?? '')) {
                  return MyStrings.enterValidEmail;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.password,
                hintText: MyStrings.passwordHint,
                isPassword: true,
                isShowSuffixIcon: true,
                controller: controller.passwordController,
                focusNode: controller.passwordFocusNode,
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.confirmPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {}),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.confirmPassword,
                hintText: MyStrings.confirmPasswordHint,
                isPassword: true,
                isShowSuffixIcon: true,
                controller: controller.confirmPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.confirmPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {}),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(needLabel: false, needOutlineBorder: true, labelText: MyStrings.referralCode, hintText: MyStrings.enterReferralCode.tr, isShowSuffixIcon: true, controller: controller.referralCodeController, validator: (value) {}, onChanged: (value) {}),
            const SizedBox(height: Dimensions.space20),
            controller.needAgree
                ? Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                              activeColor: MyColor.primaryColor,
                              value: controller.agreeTC,
                              side: WidgetStateBorderSide.resolveWith(
                                (states) => BorderSide(width: 1.0, color: controller.agreeTC ? MyColor.transparentColor : MyColor.colorGrey),
                              ),
                              onChanged: (value) {
                                controller.updateAgreeTC();
                              })),
                      const SizedBox(width: Dimensions.space10),
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            controller.updateAgreeTC();
                          },
                          child: Text("${MyStrings.iAgree} ", style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouteHelper.privacyPolicyScreen),
                          child: Text("${MyStrings.privacyPolicy.toLowerCase()} ", style: interRegularDefault.copyWith(color: MyColor.primaryColor)),
                        ),
                      ]),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: Dimensions.space20),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    press: () {
                      if (formKey.currentState!.validate()) {
                        controller.registerUser();
                      }
                    },
                    width: MediaQuery.of(context).size.width,
                    color: MyColor.primaryColor,
                    text: MyStrings.createAccount,
                    textColor: MyColor.colorWithe,
                  ),
            const SizedBox(height: Dimensions.space15),
            const SocialLoginSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(MyStrings.haveAccount, style: interRegularDefault.copyWith(color: MyColor.accountEnsureTextColor)),
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(RouteHelper.loginScreen);
                  },
                  child: Text(MyStrings.loginNow, style: interRegularDefault.copyWith(color: MyColor.primaryColor)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
