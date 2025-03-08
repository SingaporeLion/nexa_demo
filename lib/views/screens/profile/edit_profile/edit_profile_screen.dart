import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/profile/user_profile_controller.dart';
import 'package:nexa/data/repo/profile/user_profile_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/card/custom_card.dart';
import 'package:nexa/views/screens/profile/edit_profile/widget/edit_profile_form.dart';

import '../../../components/custom_loader.dart';

class EditProfileScreen extends StatefulWidget {

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {

    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(UserProfileRepo(apiClient: Get.find()));
    Get.put(UserProfileController(userProfileRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: MyColor.screenBgColor,
        appBar: AppBar(
            backgroundColor: MyColor.primaryColor,
            elevation: 0,
            title: Text(MyStrings.editProfile, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
            leading: IconButton(
              onPressed: (){
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20),
            )
        ),
        body: GetBuilder<UserProfileController>(
          builder: (controller) => controller.isLoading ? const CustomLoader() : SingleChildScrollView(
            child: Stack(
              children: [
                Container(height: MediaQuery.of(context).size.height),
                Positioned(
                  bottom: Dimensions.space50 * 3.5, left: -25,
                  child: Container(
                    height: 80, width: 80,
                    decoration: const BoxDecoration(
                        color: MyColor.smallCircleColor,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Container(
                  height: 120, width: MediaQuery.of(context).size.width,
                  color: MyColor.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10 * 1.5),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: CustomCard(
                        borderRadius: Dimensions.defaultRadius,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(controller.username, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                            const SizedBox(height: Dimensions.space5),
                            Text(controller.emailController.text, textAlign: TextAlign.center, style: interRegularDefault.copyWith(color: MyColor.primarySubTitleColor)),
                            const SizedBox(height: Dimensions.space20),
                            const EditProfileForm(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
