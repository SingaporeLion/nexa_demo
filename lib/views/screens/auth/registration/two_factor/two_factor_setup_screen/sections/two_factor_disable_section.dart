import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/two_factor_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/divider/custom_divider.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TwoFactorDisableSection extends StatelessWidget {
  const TwoFactorDisableSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TwoFactorController>(builder: (twoFactorController) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(MyStrings.disable2Fa.tr, style: interBoldExtraLarge)),
                  const CustomDivider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                    child: SmallText(text: MyStrings.twoFactorMsg.tr, textAlign: TextAlign.center, textStyle: interRegularDefault.copyWith(color: MyColor.labelTextColor)),
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
                      pinTheme: PinTheme(shape: PinCodeFieldShape.box, borderWidth: 1, borderRadius: BorderRadius.circular(5), fieldHeight: 40, fieldWidth: 40, inactiveColor: MyColor.colorGrey, inactiveFillColor: MyColor.transparentColor, activeFillColor: MyColor.transparentColor, activeColor: MyColor.primaryColor, selectedFillColor: MyColor.transparentColor, selectedColor: MyColor.primaryColor),
                      cursorColor: MyColor.colorBlack,
                      animationDuration: const Duration(milliseconds: 100),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      beforeTextPaste: (text) {
                        return true;
                      },
                      onChanged: (value) {
                        twoFactorController.currentText = value;
                        twoFactorController.update();
                      },
                    ),
                  ),
                  const SizedBox(height: Dimensions.space30),
                  twoFactorController.submitLoading
                      ? const RoundedLoadingBtn()
                      : RoundedButton(
                          press: () {
                            twoFactorController.disable2fa(twoFactorController.currentText);
                          },
                          text: MyStrings.submit.tr,
                        ),
                  const SizedBox(height: Dimensions.space30),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
