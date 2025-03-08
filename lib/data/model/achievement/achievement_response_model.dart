// To parse this JSON data, do
//
//     final achievementResponseModel = achievementResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:nexa/data/model/global/meassage_model.dart';

AchievementResponseModel achievementResponseModelFromJson(String str) => AchievementResponseModel.fromJson(json.decode(str));

String achievementResponseModelToJson(AchievementResponseModel data) => json.encode(data.toJson());

class AchievementResponseModel {
  final String? remark;
  final String? status;
  final Message? message;
  final Data? data;

  AchievementResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AchievementResponseModel.fromJson(Map<String, dynamic> json) => AchievementResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? null : Message.fromJson(json["message"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message?.toJson(),
        "data": data?.toJson(),
      };
}

class Data {
  final List<UnLockBadge>? unlockBadges;
  final List<LockBadge>? lockBadges;
  final String? badgePath;

  Data({
    this.unlockBadges,
    this.lockBadges,
    this.badgePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        unlockBadges: json["userBadges"] == null ? [] : List<UnLockBadge>.from(json["userBadges"]!.map((x) => UnLockBadge.fromJson(x))),
        lockBadges: json["badges"] == null ? [] : List<LockBadge>.from(json["badges"]!.map((x) => LockBadge.fromJson(x))),
        badgePath: json["badge_path"],
      );

  Map<String, dynamic> toJson() => {
        "unlockBadges": unlockBadges == null ? [] : List<dynamic>.from(unlockBadges!.map((x) => x)),
        "lockBadges": lockBadges == null ? [] : List<dynamic>.from(lockBadges!.map((x) => x.toJson())),
        "badge_path": badgePath,
      };
}

class LockBadge {
  final String? id;
  final String? image;
  final String? name;
  final String? earningAmount;
  final String? discountMaintenanceCost;
  final String? planPriceDiscount;
  final String? referralBonusBoost;
  final String? earningBoost;
  final String? createdAt;
  final String? updatedAt;

  LockBadge({
    this.id,
    this.image,
    this.name,
    this.earningAmount,
    this.discountMaintenanceCost,
    this.planPriceDiscount,
    this.referralBonusBoost,
    this.earningBoost,
    this.createdAt,
    this.updatedAt,
  });

  factory LockBadge.fromJson(Map<String, dynamic> json) => LockBadge(
        id: json["id"].toString(),
        image: json["image"].toString(),
        name: json["name"].toString(),
        earningAmount: json["earning_amount"].toString(),
        discountMaintenanceCost: json["discount_maintenance_cost"].toString(),
        planPriceDiscount: json["plan_price_discount"].toString(),
        referralBonusBoost: json["referral_bonus_boost"].toString(),
        earningBoost: json["earning_boost"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "image": image,
        "name": name,
        "earning_amount": earningAmount,
        "discount_maintenance_cost": discountMaintenanceCost,
        "plan_price_discount": planPriceDiscount,
        "referral_bonus_boost": referralBonusBoost,
        "earning_boost": earningBoost,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class UnLockBadge {
  final String? id;
  final String? badgeId;
  final String? image;
  final String? name;
  final String? earningAmount;
  final String? discountMaintenanceCost;
  final String? planPriceDiscount;
  final String? referralBonusBoost;
  final String? earningBoost;
  final String? createdAt;
  final String? updatedAt;
  final LockBadge? badge;
  UnLockBadge({
    this.id,
    this.badgeId,
    this.image,
    this.name,
    this.earningAmount,
    this.discountMaintenanceCost,
    this.planPriceDiscount,
    this.referralBonusBoost,
    this.earningBoost,
    this.createdAt,
    this.updatedAt,
    this.badge,
  });

  factory UnLockBadge.fromJson(Map<String, dynamic> json) => UnLockBadge(
        id: json["id"].toString(),
        badgeId: json["badge_id"].toString(),
        image: json["image"].toString(),
        name: json["name"].toString(),
        earningAmount: json["earning_amount"].toString(),
        discountMaintenanceCost: json["discount_maintenance_cost"].toString(),
        planPriceDiscount: json["plan_price_discount"].toString(),
        referralBonusBoost: json["referral_bonus_boost"].toString(),
        earningBoost: json["earning_boost"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        badge: json["badge"] == null ? null : LockBadge.fromJson(json["badge"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toString(),
        "badge_id": badgeId.toString(),
        "image": image,
        "name": name,
        "earning_amount": earningAmount,
        "discount_maintenance_cost": discountMaintenanceCost,
        "plan_price_discount": planPriceDiscount,
        "referral_bonus_boost": referralBonusBoost,
        "earning_boost": earningBoost,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "badge": badge?.toJson(),
      };
}
