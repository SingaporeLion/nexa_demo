import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:shimmer/shimmer.dart';

class MatchCardShimmer extends StatelessWidget {
  const MatchCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColor.colorGrey.withValues(alpha: 0.2),
      highlightColor: MyColor.primaryColor.withValues(alpha: 0.7),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
        height: 150,
        width: context.width,
      ),
    );
  }
}

class AchieveMentCardShimmer extends StatelessWidget {
  const AchieveMentCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColor.colorGrey.withValues(alpha: 0.2),
      highlightColor: MyColor.primaryColor.withValues(alpha: 0.7),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(color: MyColor.colorGrey.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
        height: 80,
        width: context.width,
      ),
    );
  }
}
