import 'package:flutter/material.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';

class UserInfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String data;

  const UserInfoCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.space10 + 2, horizontal: Dimensions.space15),
      decoration: BoxDecoration(
          color: MyColor.colorWhite,
          borderRadius: BorderRadius.circular(5)
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Image.asset(
              icon,
              color: MyColor.colorGrey,
              height: 16, width: 16,
            ),
            const SizedBox(width: Dimensions.space15),
            const SizedBox(
                height: 25,
                child: VerticalDivider(color: MyColor.lineColor, thickness: 1)
            ),
            const SizedBox(width: Dimensions.space15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: interRegularSmall.copyWith(color: MyColor.labelTextColor, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: Dimensions.space5),
                  Text(
                    data,
                    overflow: TextOverflow.ellipsis,
                    style: interRegularDefault.copyWith(color: MyColor.colorBlack),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
