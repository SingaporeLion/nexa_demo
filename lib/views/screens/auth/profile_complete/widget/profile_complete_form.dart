import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/auth/profile_complete/profile_complete_controller.dart';
import 'package:nexa/views/components/buttons/rounded_button.dart';
import 'package:nexa/views/components/buttons/rounded_loading_button.dart';
import 'package:nexa/views/components/text-field/custom_text_field.dart';
import 'package:nexa/views/screens/auth/profile_complete/widget/country_text_field.dart';
import 'package:nexa/views/screens/auth/registration/widget/country_bottom_sheet.dart';

class ProfileCompleteForm extends StatefulWidget {
  const ProfileCompleteForm({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteForm> createState() => _ProfileCompleteFormState();
}

class _ProfileCompleteFormState extends State<ProfileCompleteForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileCompleteController>(
      builder: (controller) => Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              focusNode: controller.userNameFocusNode,
              controller: controller.userNameController,
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.userName,
              hintText: MyStrings.enterUsername,
              onChanged: (value) {},
            ),
            const SizedBox(height: Dimensions.space20),
            if (controller.countryData == '') ...[
              CountryTextField(
                press: () {
                  CountryBottomSheet.profileCompleteCountryBottomSheet(context, controller);
                },
                text: controller.countryName == null ? MyStrings.selectACountry.tr : (controller.countryName)!.tr,
              ),
            ],
            controller.countryData != '' ? const SizedBox() : const SizedBox(height: Dimensions.space20),
            Visibility(
                visible: controller.countryData == '',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                      Container(
                        width: 50,
                        height: 47,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.defaultRadius), border: Border.all(color: controller.countryName == null ? MyColor.colorBlack : MyColor.colorGrey, width: 0.5)),
                        child: Text(
                          "+${controller.mobileCode ?? ""}",
                          style: interRegularDefault.copyWith(color: MyColor.primaryColor),
                        ),
                      ),
                      const SizedBox(width: Dimensions.space8),
                      Expanded(
                        child: CustomTextField(
                          needLabel: false,
                          needOutlineBorder: true,
                          labelText: MyStrings.phoneNo,
                          hintText: MyStrings.enterPhoneNo,
                          onChanged: (value) {},
                          focusNode: controller.mobileNoFocusNode,
                          controller: controller.mobileController,
                        ),
                      ),
                    ]),
                  ],
                )),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.address,
              hintText: MyStrings.enterYourAddress,
              onChanged: (value) {},
              focusNode: controller.addressFocusNode,
              controller: controller.addressController,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.state,
              hintText: MyStrings.enterYourState,
              onChanged: (value) {},
              focusNode: controller.stateFocusNode,
              controller: controller.stateController,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.zipCode,
              hintText: MyStrings.enterYourZipcode,
              onChanged: (value) {},
              focusNode: controller.zipCodeFocusNode,
              controller: controller.zipCodeController,
            ),
            const SizedBox(height: Dimensions.space20),
            CustomTextField(
              needLabel: false,
              needOutlineBorder: true,
              labelText: MyStrings.city,
              hintText: MyStrings.enterYourCity,
              onChanged: (value) {},
              focusNode: controller.cityFocusNode,
              controller: controller.cityController,
            ),
            const SizedBox(height: Dimensions.space25),
            controller.submitLoading
                ? const RoundedLoadingBtn()
                : RoundedButton(
                    press: () {
                      controller.updateProfile();
                    },
                    width: MediaQuery.of(context).size.width,
                    color: MyColor.primaryColor,
                    text: MyStrings.updateProfile,
                    textColor: MyColor.colorWhite,
                  )
          ],
        ),
      ),
    );
  }
}
