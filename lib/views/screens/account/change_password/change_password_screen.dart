import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/account/change_password_controller.dart';
import 'package:nexa/data/repo/account/change_password_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/screens/account/change_password/widget/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiClient: Get.find()));
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColor.colorWhite,
        appBar: const CustomAppBar(title: MyStrings.changePassword, isShowBackBtn: true, bgColor: MyColor.primaryColor),
        body: GetBuilder<ChangePasswordController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MyStrings.createNewPassword,
                    style: interRegularExtraLarge.copyWith(color: MyColor.colorBlack, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .25),
                    child: Text(MyStrings.createPasswordSubText, style: interRegularDefault.copyWith(color: MyColor.colorBlack.withValues(alpha: 0.5))),
                  ),
                  const SizedBox(height: Dimensions.space35),
                  const ChangePasswordForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
