// To parse this JSON data, do
//
//     final generalSettingResponseModel = generalSettingResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:nexa/data/model/auth/sign_up_model/sign_up_response_model.dart';


GeneralSettingResponseModel generalSettingResponseModelFromJson(String str) => GeneralSettingResponseModel.fromJson(json.decode(str));

String generalSettingResponseModelToJson(GeneralSettingResponseModel data) => json.encode(data.toJson());

class GeneralSettingResponseModel {
  String? remark;
  String? status;
  Message? message;
  Data? data;

  GeneralSettingResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) => GeneralSettingResponseModel(
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
  GeneralSetting? generalSetting;
  String? socialLoginRedirect;
  Data({
    this.generalSetting,
    this.socialLoginRedirect,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        generalSetting: json["general_setting"] == null ? null : GeneralSetting.fromJson(json["general_setting"]),
        socialLoginRedirect: json["social_login_redirect"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "general_setting": generalSetting?.toJson(),
        "social_login_redirect": socialLoginRedirect,
      };
}

class GeneralSetting {
  int? id;
  String? siteName;
  String? curText;
  String? curSym;
  String? smsFrom;

  String? baseColor;
  String? kv;
  String? ev;
  String? en;
  String? sv;
  String? sn;
  String? forceSsl;
  String? maintenanceMode;
  String? securePassword;
  String? agree;
  String? multiLanguage;
  String? registration;
  String? activeTemplate;
  String? defaultTheme;
  String? systemCustomized;
  String? depositCommission;
  String? tradeCommission;
  String? lastCron;
  String? allowDecimalAfterNumber;
  String? metamaskLogin;
  String? p2PTradeCharge;
  String? otherUserTransferCharge;
  String? createdAt;
  String? updatedAt;
  SocialiteCredentials? socialiteCredentials;
  GeneralSetting(
      {this.id,
      this.siteName,
      this.curText,
      this.curSym,
      this.smsFrom,
      this.baseColor,
      this.kv,
      this.ev,
      this.en,
      this.sv,
      this.sn,
      this.forceSsl,
      this.maintenanceMode,
      this.securePassword,
      this.agree,
      this.multiLanguage,
      this.registration,
      this.activeTemplate,
      this.defaultTheme,
      this.systemCustomized,
      this.depositCommission,
      this.tradeCommission,
      this.lastCron,
      this.allowDecimalAfterNumber,
      this.metamaskLogin,
      this.p2PTradeCharge,
      this.otherUserTransferCharge,
      this.createdAt,
      this.updatedAt,
      this.socialiteCredentials});

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        id: json["id"],
        siteName: json["site_name"].toString(),
        curText: json["cur_text"].toString(),
        curSym: json["cur_sym"].toString(),
        smsFrom: json["sms_from"].toString(),
        baseColor: json["base_color"].toString(),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        en: json["en"].toString(),
        sv: json["sv"].toString(),
        sn: json["sn"].toString(),
        forceSsl: json["force_ssl"].toString(),
        maintenanceMode: json["maintenance_mode"].toString(),
        securePassword: json["secure_password"].toString(),
        agree: json["agree"].toString(),
        multiLanguage: json["multi_language"].toString(),
        registration: json["registration"].toString(),
        activeTemplate: json["active_template"].toString(),
        defaultTheme: json["default_theme"].toString(),
        systemCustomized: json["system_customized"].toString(),
        depositCommission: json["deposit_commission"].toString(),
        tradeCommission: json["trade_commission"].toString(),
        lastCron: json["last_cron"].toString(),
        allowDecimalAfterNumber: json["allow_decimal_after_number"].toString(),
        metamaskLogin: json["metamask_login"].toString(),
        p2PTradeCharge: json["p2p_trade_charge"].toString(),
        otherUserTransferCharge: json["other_user_transfer_charge"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        socialiteCredentials: json["socialite_credentials"] == null ? null : SocialiteCredentials.fromJson(json["socialite_credentials"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "cur_text": curText,
        "cur_sym": curSym,
        "sms_from": smsFrom,
        "base_color": baseColor,
        "kv": kv,
        "ev": ev,
        "en": en,
        "sv": sv,
        "sn": sn,
        "force_ssl": forceSsl,
        "maintenance_mode": maintenanceMode,
        "secure_password": securePassword,
        "agree": agree,
        "multi_language": multiLanguage,
        "registration": registration,
        "active_template": activeTemplate,
        "default_theme": defaultTheme,
        "system_customized": systemCustomized,
        "deposit_commission": depositCommission,
        "trade_commission": tradeCommission,
        "last_cron": lastCron,
        "allow_decimal_after_number": allowDecimalAfterNumber,
        "metamask_login": metamaskLogin,
        "p2p_trade_charge": p2PTradeCharge,
        "other_user_transfer_charge": otherUserTransferCharge,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "socialite_credentials": socialiteCredentials?.toJson(),
      };
}

class SocialiteCredentials {
  SocialiteCredentialValue? google;
  SocialiteCredentialValue? facebook;
  SocialiteCredentialValue? linkedin;

  SocialiteCredentials({
    this.google,
    this.facebook,
    this.linkedin,
  });

  factory SocialiteCredentials.fromJson(Map<String, dynamic> json) => SocialiteCredentials(
        google: json["google"] == null ? null : SocialiteCredentialValue.fromJson(json["google"]),
        facebook: json["facebook"] == null ? null : SocialiteCredentialValue.fromJson(json["facebook"]),
        linkedin: json["linkedin"] == null ? null : SocialiteCredentialValue.fromJson(json["linkedin"]),
      );

  Map<String, dynamic> toJson() => {
        "google": google?.toJson(),
        "facebook": facebook?.toJson(),
        "linkedin": linkedin?.toJson(),
      };
}

class SocialiteCredentialValue {
  String? clientId;
  String? clientSecret;
  String? status;

  SocialiteCredentialValue({
    this.clientId,
    this.clientSecret,
    this.status,
  });

  factory SocialiteCredentialValue.fromJson(Map<String, dynamic> json) => SocialiteCredentialValue(
        clientId: json["client_id"].toString(),
        clientSecret: json["client_secret"].toString(),
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "client_secret": clientSecret,
        "status": status,
      };
}
