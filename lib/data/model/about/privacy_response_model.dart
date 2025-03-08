// To parse this JSON data, do
//
//     final privacyResponseModel = privacyResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:nexa/data/model/auth/registration_response_model.dart';

PrivacyResponseModel privacyResponseModelFromJson(String str) => PrivacyResponseModel.fromJson(json.decode(str));

String privacyResponseModelToJson(PrivacyResponseModel data) => json.encode(data.toJson());

class PrivacyResponseModel {
    String? remark;
    String? status;
    Message? message;
    Data? data;

    PrivacyResponseModel({
        this.remark,
        this.status,
        this.message,
        this.data,
    });

    factory PrivacyResponseModel.fromJson(Map<String, dynamic> json) => PrivacyResponseModel(
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
    List<Policy>? policies;

    Data({
        this.policies,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        policies: json["policies"] == null ? [] : List<Policy>.from(json["policies"]!.map((x) => Policy.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "policies": policies == null ? [] : List<dynamic>.from(policies!.map((x) => x.toJson())),
    };
}

class Policy {
    int? id;
    String? dataKeys;
    String? tempname;
    DataValues? dataValues;
    dynamic seoContent;
    String? slug;
    DateTime? createdAt;
    DateTime? updatedAt;

    Policy({
        this.id,
        this.dataKeys,
        this.tempname,
        this.dataValues,
        this.seoContent,
        this.slug,
        this.createdAt,
        this.updatedAt,
    });

    factory Policy.fromJson(Map<String, dynamic> json) => Policy(
        id: json["id"],
        dataKeys: json["data_keys"],
        tempname: json["tempname"],
        dataValues: json["data_values"] == null ? null : DataValues.fromJson(json["data_values"]),
        seoContent: json["seo_content"],
        slug: json["slug"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "data_keys": dataKeys,
        "tempname": tempname,
        "data_values": dataValues?.toJson(),
        "seo_content": seoContent,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class DataValues {
    String? title;
    String? description;

    DataValues({
        this.title,
        this.description,
    });

    factory DataValues.fromJson(Map<String, dynamic> json) => DataValues(
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
    };
}


