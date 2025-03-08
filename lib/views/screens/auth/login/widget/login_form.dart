import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/login/login_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/text-field/custom_text_field.dart';
import 'package:nexa/views/screens/auth/login/widget/social_login_section.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return GetBuilder<LoginController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
                needLabel: false,
                needOutlineBorder: true,
                textInputType: TextInputType.text,
                labelText: MyStrings.username,
                hintText: MyStrings.usernameHint,
                controller: controller.usernameController,
                focusNode: controller.usernameFocusNode,
                nextFocus: controller.passwordFocusNode,
                onChanged: (value) {
                  return ;
                },
                validator: (value){
                  if(value!.isEmpty){
                    return MyStrings.pleaseEnterUsername;
                  }
                  else{
                    return null;
                  }
                }
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              textInputType: TextInputType.text,
              labelText: MyStrings.password,
              hintText: MyStrings.passwordHint,
              isPassword: true,
              isShowSuffixIcon: true,
              controller: controller.passwordController,
              focusNode: controller.passwordFocusNode,
              onChanged: (value) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.pleaseEnterPassword;
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: Dimensions.space10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.changeRememberMe();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                            activeColor: MyColor.primaryColor,
                            value: controller.remember,
                            side: MaterialStateBorderSide.resolveWith((states) => BorderSide(
                                width: 1.0,
                                color: controller.remember ? MyColor.transparentColor : MyColor.colorGrey),
                            ),
                            onChanged: (value) {
                              controller.changeRememberMe();
                            }
                        ),
                      ),
                      const SizedBox(width: Dimensions.space10),
                      Text(MyStrings.rememberMe,
                        style: interRegularSmall.copyWith(color: MyColor.colorBlack),overflow: TextOverflow.ellipsis,)
                    ],
                  ),
                ),
                TextButton(
                  onPressed: (){
                    controller.clearData();
                    controller.forgetPassword();
                  },
                  child:  Text("${MyStrings.forgotPassword.tr}", style: interRegularSmall),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space15),
            controller.isSubmit ? const RoundedLoadingBtn() : RoundedButton(
              press: (){
                if(formKey.currentState!.validate()){
                  controller.loginUser();
                }
              },
              width: MediaQuery.of(context).size.width,
              color: MyColor.primaryColor,
              text: MyStrings.login,
              textColor: MyColor.colorWhite,
            ),
            const SocialLoginSection(),
            const SizedBox(height: Dimensions.space15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(MyStrings.noAccount, style: interRegularDefault.copyWith(color: MyColor.accountEnsureTextColor))),
                TextButton(
                  onPressed: (){
                    Get.offAndToNamed(RouteHelper.registrationScreen);
                    controller.clearData();
                  },
                  child: Text(MyStrings.createNew, style: interRegularDefault.copyWith(color: MyColor.primaryColor)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
