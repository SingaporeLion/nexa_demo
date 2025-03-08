import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/controller/account/change_password_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/text-field/custom_text_field.dart';

class ChangePasswordForm extends StatefulWidget {

  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChangePasswordController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.currentPassword,
                hintText: MyStrings.currentPasswordHint,
                controller: controller.currentPassController,
                focusNode: controller.currentPassFocusNode,
                nextFocus: controller.passwordFocusNode,
                isPassword: true,
                isShowSuffixIcon: true,
                onChanged: (value) {}
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.newPassword,
                hintText: MyStrings.passwordHint,
                controller: controller.passController,
                focusNode: controller.passwordFocusNode,
                nextFocus: controller.confirmPassFocusNode,
                isPassword: true,
                isShowSuffixIcon: true,
                onChanged: (value) {}
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                labelText: MyStrings.confirmNewPassword,
                hintText: MyStrings.confirmPasswordHint,
                controller: controller.confirmPassController,
                focusNode: controller.confirmPassFocusNode,
                inputAction: TextInputAction.done,
                isPassword: true,
                isShowSuffixIcon: true,
                onChanged: (value) {}
            ),
            const SizedBox(height: Dimensions.space25),
            controller.submitLoading ? const RoundedLoadingBtn() : RoundedButton(
              press: (){
                FocusScope.of(context).unfocus();
                controller.changePassword();
              },
              width: MediaQuery.of(context).size.width,
              color: MyColor.primaryColor,
              text: MyStrings.changePassword,
              textColor: MyColor.colorWhite,
            ),
          ],
        ),
      ),
    );
  }
}
