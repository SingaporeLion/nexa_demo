import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/achievement/achievement_response_model.dart';
import 'package:nexa/data/model/authorization/authorization_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/repo/achievement/achievement_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class AchievementController extends GetxController {
  final AchievementRepo achievementRepo;

  AchievementController({required this.achievementRepo});

  List<LockBadge> lockBadges = [];
  List<UnLockBadge> unlockBadges = [];
  String? badgePath;
  bool isLoading = false;

  Future<void> getAchievement() async {
    isLoading = true;
    update();
    try {
      final ResponseModel responseModel = await achievementRepo.getAchievement();
      if (responseModel.statusCode == 200) {
        AchievementResponseModel model = AchievementResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == "success") {
          //
          lockBadges = model.data?.lockBadges ?? [];
          unlockBadges = model.data?.unlockBadges ?? [];
          badgePath = model.data?.badgePath;
          update();
          if (unlockBadges.isNotEmpty) {
            lockBadges.removeWhere((lock) => unlockBadges.any((unlock) => unlock.badgeId == lock.id));
          }
        } else {
          CustomSnackBar.error(errorList: model.message?.error ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading = false;
      update();
    }
  }
}
