import '../../auth/registration_response_model.dart';

class MyReferralResponseModel {
  MyReferralResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  MyReferralResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? referralLink, 
      String? maxLevel, 
      List<Referrals>? referrals}){
    _referralLink = referralLink;
    _maxLevel = maxLevel;
    _referrals = referrals;
}

  Data.fromJson(dynamic json) {
    _referralLink = json['referral_link'];
    _maxLevel = json['maxLevel'].toString();
    if (json['referrals'] != null) {
      _referrals = [];
      json['referrals'].forEach((v) {
        _referrals?.add(Referrals.fromJson(v));
      });
    }
  }
  String? _referralLink;
  String? _maxLevel;
  List<Referrals>? _referrals;

  String? get referralLink => _referralLink;
  String? get maxLevel => _maxLevel;
  List<Referrals>? get referrals => _referrals;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referral_link'] = _referralLink;
    map['maxLevel'] = _maxLevel;
    if (_referrals != null) {
      map['referrals'] = _referrals?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Referrals {
  Referrals({
      int? id, 
      String? username, 
      String? level,}){
    _id = id;
    _username = username;
    _level = level;
}

  Referrals.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _level = json['level'].toString();
  }
  int? _id;
  String? _username;
  String? _level;

  int? get id => _id;
  String? get username => _username;
  String? get level => _level;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['level'] = _level;
    return map;
  }

}