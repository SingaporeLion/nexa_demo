import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/profile/user_profile_controller.dart';
import 'package:nexa/data/repo/profile/user_profile_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/custom_loader.dart';
import 'package:nexa/views/components/text/small_text.dart';
import 'package:nexa/views/screens/profile/user_profile/widget/user_info_card.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {

    MyUtils.allScreenUtil();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(UserProfileRepo(apiClient: Get.find()));
    final controller = Get.put(UserProfileController(userProfileRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreenUtil();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColor.screenBgColor,
      appBar: AppBar(
        backgroundColor: MyColor.primaryColor,
        elevation: 0,
        title: Text(MyStrings.profile, style: interRegularLarge.copyWith(color: MyColor.colorWhite)),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: MyColor.colorWhite, size: 20),
        )
      ),
      body: GetBuilder<UserProfileController>(
        builder: (controller) => controller.isLoading ? const CustomLoader() : SingleChildScrollView(
          padding: Dimensions.screenPaddingHV,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
                decoration: BoxDecoration(color: MyColor.primaryColor, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.username, style: interRegularLarge.copyWith(color: MyColor.colorWhite, fontWeight: FontWeight.w600)),
                        const SizedBox(height: Dimensions.space5),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,color: MyColor.circleContainerColor1,size: 16,),
                            SmallText(text: controller.countryName, textColor: MyColor.circleContainerColor1),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                      child: Container(
                        height: 30, width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: MyColor.circleContainerColor1,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Text(MyStrings.editProfile, textAlign: TextAlign.center, style: interRegularSmall.copyWith(color: MyColor.colorBlack)),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: Dimensions.space15),
              UserInfoCard(
                  icon: MyImages.user,
                  title: MyStrings.username,
                  data: controller.username
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.email,
                  title: MyStrings.email,
                  data: controller.emailController.text,
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.phone,
                  title: MyStrings.mobileNumber,
                  data: "+${controller.mobileNoController.text}"
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.address,
                  title: MyStrings.address,
                  data: controller.addressController.text
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.country,
                  title: MyStrings.country,
                  data: controller.countryName
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.state,
                  title: MyStrings.state,
                  data: controller.stateController.text
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.city,
                  title: MyStrings.city,
                  data: controller.cityController.text
              ),
              const SizedBox(height: Dimensions.space5),
              UserInfoCard(
                  icon: MyImages.zipCode,
                  title: MyStrings.zipCode,
                  data: controller.zipCodeController.text
              )
            ],
          ),
        ),
      ),
    );
  }
}
