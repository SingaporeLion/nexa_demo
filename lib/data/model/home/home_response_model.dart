import 'package:nexa/data/model/auth/registration_response_model.dart';

class HomeResponseModel {
  HomeResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  HomeResponseModel.fromJson(dynamic json) {
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
      String? coinImagePath, 
      Widget? widget, 
      List<Miners>? miners, 
      List<Transactions>? transactions, 
      Plan? plan,}){
    _referralLink = referralLink;
    _coinImagePath = coinImagePath;
    _widget = widget;
    _miners = miners;
    _transactions = transactions;
    _plan = plan;
}

  Data.fromJson(dynamic json) {
    _referralLink = json['referral_link'] !=null? json['referral_link'].toString():'';
    _coinImagePath = json['coin_image_path']!=null?json['coin_image_path'].toString():'';
    _widget = json['widget'] != null ? Widget.fromJson(json['widget']) : null;
    if (json['miners'] != null) {
      _miners = [];
      json['miners'].forEach((v) {
        _miners?.add(Miners.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }
  String? _referralLink;
  String? _coinImagePath;
  Widget? _widget;
  List<Miners>? _miners;
  List<Transactions>? _transactions;
  Plan? _plan;

  String? get referralLink => _referralLink;
  String? get coinImagePath => _coinImagePath;
  Widget? get widget => _widget;
  List<Miners>? get miners => _miners;
  List<Transactions>? get transactions => _transactions;
  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referral_link'] = _referralLink;
    map['coin_image_path'] = _coinImagePath;
    if (_widget != null) {
      map['widget'] = _widget?.toJson();
    }
    if (_miners != null) {
      map['miners'] = _miners?.map((v) => v.toJson()).toList();
    }
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }

}

class Plan {
  Plan({
      String? pending,
      String? approved,
      String? rejected,
      String? unpaid,}){
    _pending = pending;
    _approved = approved;
    _rejected = rejected;
    _unpaid = unpaid;
}

  Plan.fromJson(dynamic json) {
    _pending = json['pending'].toString();
    _approved = json['approved'].toString();
    _rejected = json['rejected'].toString();
    _unpaid = json['unpaid'].toString();
  }
  String? _pending;
  String? _approved;
  String? _rejected;
  String? _unpaid;

  String? get pending => _pending;
  String? get approved => _approved;
  String? get rejected => _rejected;
  String? get unpaid => _unpaid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pending'] = _pending;
    map['approved'] = _approved;
    map['rejected'] = _rejected;
    map['unpaid'] = _unpaid;
    return map;
  }

}

class Transactions {
  Transactions({
      int? id,
      String? amount, 
      String? charge, 
      String? currency, 
      String? postBalance, 
      String? trxType, 
      String? trx, 
      String? details, 
      String? remark, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _amount = amount;
    _charge = charge;
    _currency = currency;
    _postBalance = postBalance;
    _trxType = trxType;
    _trx = trx;
    _details = details;
    _remark = remark;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Transactions.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount']!=null?json['amount'].toString():'0';
    _charge = json['charge']!=null?json['charge'].toString():'0';
    _currency = json['currency'].toString();
    _postBalance = json['post_balance']!=null?json['post_balance'].toString():'0';
    _trxType = json['trx_type'].toString();
    _trx = json['trx'].toString();
    _details = json['details']!=null?json['details'].toString():'';
    _remark = json['remark'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _amount;
  String? _charge;
  String? _currency;
  String? _postBalance;
  String? _trxType;
  String? _trx;
  String? _details;
  String? _remark;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get currency => _currency;
  String? get postBalance => _postBalance;
  String? get trxType => _trxType;
  String? get trx => _trx;
  String? get details => _details;
  String? get remark => _remark;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['currency'] = _currency;
    map['post_balance'] = _postBalance;
    map['trx_type'] = _trxType;
    map['trx'] = _trx;
    map['details'] = _details;
    map['remark'] = _remark;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Miners {
  Miners({
      int? id, 
      String? name, 
      String? coinCode, 
      String? coinImage, 
      String? minWithdrawLimit, 
      String? maxWithdrawLimit, 
      UserCoinBalances? userCoinBalances}){
    _id = id;
    _name = name;
    _coinCode = coinCode;
    _coinImage = coinImage;
    _minWithdrawLimit = minWithdrawLimit;
    _maxWithdrawLimit = maxWithdrawLimit;
    _userCoinBalances = userCoinBalances;
}

  Miners.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _coinCode = json['coin_code']!=null?json['coin_code'].toString():'';
    _coinImage = json['coin_image'].toString();
    _minWithdrawLimit = json['min_withdraw_limit'] !=null? json['min_withdraw_limit'].toString():'0';
    _maxWithdrawLimit = json['max_withdraw_limit'] !=null? json['max_withdraw_limit'].toString():'0';
    _userCoinBalances = json['user_coin_balances'] != null? UserCoinBalances.fromJson(json['user_coin_balances']) : null;
  }

  int? _id;
  String? _name;
  String? _coinCode;
  String? _coinImage;
  String? _minWithdrawLimit;
  String? _maxWithdrawLimit;
  UserCoinBalances? _userCoinBalances;

  int? get id => _id;
  String? get name => _name;
  String? get coinCode => _coinCode;
  String? get coinImage => _coinImage;
  String? get minWithdrawLimit => _minWithdrawLimit;
  String? get maxWithdrawLimit => _maxWithdrawLimit;
  UserCoinBalances? get userCoinBalances => _userCoinBalances;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['coin_code'] = _coinCode;
    map['coin_image'] = _coinImage;
    map['min_withdraw_limit'] = _minWithdrawLimit;
    map['max_withdraw_limit'] = _maxWithdrawLimit;
    if (_userCoinBalances != null) {
      map['user_coin_balances'] = _userCoinBalances?.toJson();
    }
    return map;
  }

}

class UserCoinBalances {
  UserCoinBalances({
      int? id, 
      String? userId,
      String? minerId,
      String? wallet, 
      String? balance, 
      String? createdAt, 
      String? updatedAt}){
    _id = id;
    _userId = userId;
    _minerId = minerId;
    _wallet = wallet;
    _balance = balance;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  UserCoinBalances.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _minerId = json['miner_id'].toString();
    _wallet = json['wallet'].toString();
    _balance = json['balance']!=null?json['balance'].toString():'0';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _userId;
  String? _minerId;
  String? _wallet;
  String? _balance;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get userId => _userId;
  String? get minerId => _minerId;
  String? get wallet => _wallet;
  String? get balance => _balance;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['miner_id'] = _minerId;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Widget {

  Widget({
      String? referralBonus, 
      String? balance}){
    _referralBonus = referralBonus;
    _balance = balance;
}

  Widget.fromJson(dynamic json) {
    _referralBonus = json['referral_bonus'].toString();
    _balance = json['balance'].toString();
  }

  String? _referralBonus;
  String? _balance;

  String? get referralBonus => _referralBonus;
  String? get balance => _balance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referral_bonus'] = _referralBonus;
    map['balance'] = _balance;
    return map;
  }

}