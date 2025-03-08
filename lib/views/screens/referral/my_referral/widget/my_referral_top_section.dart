import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/referral/my_referral_controller.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class MyReferralTopSection extends StatelessWidget {
  const MyReferralTopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyReferralController>(
      builder: (controller) => Stack(
        clipBehavior:Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            color: MyColor.primaryColor,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space20, horizontal: Dimensions.space15),
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
              decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(MyStrings.referralLink, style: interSemiBoldDefault.copyWith(color: MyColor.colorBlack)),
                  const SizedBox(height: Dimensions.space5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.72,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
                        decoration: BoxDecoration(
                            color: MyColor.transparentColor,
                            borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                            border: Border.all(color: MyColor.primaryColor, width: 0.5)
                        ),
                        child: Text(controller.referralLink, style: interRegularDefault.copyWith(color: MyColor.colorBlack)),
                      ),
                      const SizedBox(width: Dimensions.space15),
                      GestureDetector(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: controller.referralLink));
                          CustomSnackBar.showCustomSnackBar(errorList: [], msg: [MyStrings.referralLinkCopied], isError: false);
                        },
                        child: const Icon(Icons.copy, color: MyColor.primaryColor, size: 20),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
