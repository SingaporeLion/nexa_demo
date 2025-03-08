import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';

class WithdrawStatusBtn extends StatelessWidget {
  final String status;
  const WithdrawStatusBtn({Key? key,required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: status == "1" ? MyColor.primaryColor
              : status == "2" ? Colors.orangeAccent
              : status == "3" ? Colors.red : MyColor.primaryColor)
      ),
      child: Text(
        status == "1" ? MyStrings.approved
            : status == "2" ? MyStrings.pending
            : status == "3" ? MyStrings.rejected
            : "",
        textAlign: TextAlign.center,
        style: interRegularDefault.copyWith(
            color: status == "1" ? MyColor.primaryColor
                : status == "2" ? Colors.orangeAccent
                : status == "3" ? Colors.red : MyColor.primaryColor,
            fontSize: Dimensions.fontExtraSmall
        ),
      ),
    );
  }
}
