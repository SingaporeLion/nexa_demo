import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_images.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';

class NoDataWidget extends StatelessWidget {
  final double margin;
  String? text;
  NoDataWidget({
    super.key,
    this.margin = 4,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(MyImages.noData, height: 120, width: 120),
          const SizedBox(height: Dimensions.space3),
          Text(
            MyStrings.noDataToShow.tr,
            style: interRegularDefault.copyWith(color: MyColor.colorBlack),
          )
        ],
      ),
    );
  }
}
