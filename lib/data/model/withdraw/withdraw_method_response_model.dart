import '../auth/registration_response_model.dart';

class WithdrawMethodResponseModel {
  WithdrawMethodResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  WithdrawMethodResponseModel.fromJson(dynamic json) {
    _remark = json['remark'].toString();
    _status = json['status'].toString();
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
      List<WithdrawMethod>? withdrawMethod,}){
    _withdrawMethod = withdrawMethod;
}

  Data.fromJson(dynamic json) {
    if (json['withdrawMethod'] != null) {
      _withdrawMethod = [];
      json['withdrawMethod'].forEach((v) {
        _withdrawMethod?.add(WithdrawMethod.fromJson(v));
      });
    }
  }
  List<WithdrawMethod>? _withdrawMethod;

  List<WithdrawMethod>? get withdrawMethod => _withdrawMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdrawMethod != null) {
      map['withdrawMethod'] = _withdrawMethod?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class WithdrawMethod {
  WithdrawMethod({
      int? id, 
      String? userId,
      String? minerId,
      String? wallet, 
      String? balance, 
      String? createdAt, 
      String? updatedAt, 
      Miner? miner,}){
    _id = id;
    _userId = userId;
    _minerId = minerId;
    _wallet = wallet;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _miner = miner;
}

  WithdrawMethod.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _minerId = json['miner_id'].toString();
    _wallet = json['wallet']!=null?json['wallet'].toString():'';
    _balance = json['balance'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
    _miner = json['miner'] != null ? Miner.fromJson(json['miner']) : null;
  }
  int? _id;
  String? _userId;
  String? _minerId;
  String? _wallet;
  String? _balance;
  String? _createdAt;
  String? _updatedAt;
  Miner? _miner;

  int? get id => _id;
  String? get userId => _userId;
  String? get minerId => _minerId;
  String? get wallet => _wallet;
  String? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Miner? get miner => _miner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['miner_id'] = _minerId;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_miner != null) {
      map['miner'] = _miner?.toJson();
    }
    return map;
  }

}

class Miner {
  Miner({
      int? id, 
      String? name, 
      String? coinCode, 
      String? coinImage, 
      String? minWithdrawLimit, 
      String? maxWithdrawLimit,}){
    _id = id;
    _name = name;
    _coinCode = coinCode;
    _coinImage = coinImage;
    _minWithdrawLimit = minWithdrawLimit;
    _maxWithdrawLimit = maxWithdrawLimit;
}

  Miner.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _coinCode = json['coin_code'].toString();
    _coinImage = json['coin_image'].toString();
    _minWithdrawLimit = json['min_withdraw_limit'].toString();
    _maxWithdrawLimit = json['max_withdraw_limit'].toString();
  }
  int? _id;
  String? _name;
  String? _coinCode;
  String? _coinImage;
  String? _minWithdrawLimit;
  String? _maxWithdrawLimit;

  int? get id => _id;
  String? get name => _name;
  String? get coinCode => _coinCode;
  String? get coinImage => _coinImage;
  String? get minWithdrawLimit => _minWithdrawLimit;
  String? get maxWithdrawLimit => _maxWithdrawLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['coin_code'] = _coinCode;
    map['coin_image'] = _coinImage;
    map['min_withdraw_limit'] = _minWithdrawLimit;
    map['max_withdraw_limit'] = _maxWithdrawLimit;
    return map;
  }

}