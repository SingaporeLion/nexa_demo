import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/core/utils/util.dart';
import 'package:nexa/data/controller/auth/login/login_controller.dart';
import 'package:nexa/data/repo/auth/login/login_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/auth_components/auth_layout.dart';
import 'package:nexa/views/components/will_pop_widget.dart';
import 'package:nexa/views/screens/auth/login/widget/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    MyUtils.authScreenUtils();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(LoginRepo(apiClient: Get.find()));
    Get.put(LoginController(loginRepo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    MyUtils.authScreenUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: MyColor.screenBgColor,
            body: GetBuilder<LoginController>(
              builder: (controller) => AuthLayout(
                bottomSpace: Dimensions.space35,
                imageUrl: MyImages.loginImage,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(MyStrings.loginTitle, textAlign: TextAlign.center, style: interRegularExtraLarge.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: Dimensions.space30),
                      const LoginForm(),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
