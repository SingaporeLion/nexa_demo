import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/controller/auth/profile_complete/profile_complete_controller.dart';
import 'package:nexa/data/repo/auth/profile_complete/profile_complete_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/appbar/custom_appbar.dart';
import 'package:nexa/views/components/card/custom_card.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:nexa/views/screens/auth/profile_complete/widget/profile_complete_form.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileCompleteRepo(
      apiClient: Get.find(),
    ));
    final controller = Get.put(ProfileCompleteController(profileRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initialData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: "",
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.screenBgColor,
          appBar: const CustomAppBar(
            isProfileCompleted: true,
            title: MyStrings.profileComplete,
            isShowBackBtn: true,
            bgColor: MyColor.primaryColor,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height),
                Positioned(
                  bottom: Dimensions.space50 * 4,
                  left: -25,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(color: MyColor.smallCircleColor, shape: BoxShape.circle),
                  ),
                ),
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: MyColor.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                ),
              const  Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10 * 1.5),
                    child: SingleChildScrollView(
                      physics:  ClampingScrollPhysics(),
                      child: CustomCard(
                        verticalPadding: Dimensions.space25,
                        borderRadius: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            ProfileCompleteForm(),
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
