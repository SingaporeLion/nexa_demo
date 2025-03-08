import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({
       Key? key,
       required this.name,
       required this.hasError
  }) : super(key: key);

  final String name;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Chip(
          avatar: Icon(hasError?Icons.cancel:Icons.check_circle,color: hasError?Colors.red:Colors.green,size: 15,),

          label: Text(
            name,
            style: interRegularSmall.copyWith(
              fontSize: Dimensions.fontExtraSmall,
              color: hasError?Colors.red:Colors.green,
            ),
          ),
          backgroundColor: MyColor.screenBgColor,
        ),
        const SizedBox(width: 5,),
      ],
    );
  }
}