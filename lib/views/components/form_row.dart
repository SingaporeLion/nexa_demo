import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class FormRow extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormRow({Key? key, required this.label, required this.isRequired}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: interSemiBoldExtraLarge.copyWith(fontSize: Dimensions.fontDefault, color: MyColor.labelTextColor),
        ),
        Text(
          isRequired ? ' *' : '',
          style: interBoldDefault.copyWith(color: Colors.red),
        )
      ],
    );
  }
}
