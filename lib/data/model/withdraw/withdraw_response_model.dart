import '../auth/registration_response_model.dart';

class WithdrawResponseModel {
  WithdrawResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  WithdrawResponseModel.fromJson(dynamic json) {
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
      Withdraws? withdraws,}){
    _withdraws = withdraws;
}

  Data.fromJson(dynamic json) {
    _withdraws = json['withdraws'] != null ? Withdraws.fromJson(json['withdraws']) : null;
  }
  Withdraws? _withdraws;

  Withdraws? get withdraws => _withdraws;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_withdraws != null) {
      map['withdraws'] = _withdraws?.toJson();
    }
    return map;
  }

}

class Withdraws {
  Withdraws({
      List<WithdrawData>? data,
      dynamic nextPageUrl, 
      String? path, 
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;

}

  Withdraws.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(WithdrawData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'].toString();
  }

  List<WithdrawData>? _data;
  dynamic _nextPageUrl;
  String? _path;


  List<WithdrawData>? get data => _data;
  dynamic get nextPageUrl => _nextPageUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    return map;
  }

}

class Links {
  Links({
      dynamic url, 
      String? label, 
      bool? active,}){
    _url = url;
    _label = label;
    _active = active;
}

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'].toString();
    _active = json['active'];
  }
  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;
  String? get label => _label;
  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }

}

class WithdrawData {
  WithdrawData({
      int? id, 
      String? userId, 
      String? userCoinBalanceId, 
      String? amount, 
      String? currency, 
      String? trx, 
      String? finalAmount, 
      String? status, 
      dynamic adminFeedback, 
      String? createdAt, 
      UserCoinBalance? userCoinBalance,}){
    _id = id;
    _userId = userId;
    _userCoinBalanceId = userCoinBalanceId;
    _amount = amount;
    _currency = currency;
    _trx = trx;
    _finalAmount = finalAmount;
    _status = status;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _userCoinBalance = userCoinBalance;
}

  WithdrawData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _userCoinBalanceId = json['user_coin_balance_id'].toString();
    _amount = json['amount'].toString();
    _currency = json['currency'].toString();
    _trx = json['trx'].toString();
    _finalAmount = json['final_amount'].toString();
    _status = json['status'].toString();
    _adminFeedback = json['admin_feedback'].toString();
    _createdAt = json['created_at'].toString();
    _userCoinBalance = json['user_coin_balance'] != null ? UserCoinBalance.fromJson(json['user_coin_balance']) : null;
  }
  int? _id;
  String? _userId;
  String? _userCoinBalanceId;
  String? _amount;
  String? _currency;
  String? _trx;
  String? _finalAmount;
  String? _status;
  dynamic _adminFeedback;
  String? _createdAt;
  UserCoinBalance? _userCoinBalance;

  int? get id => _id;
  String? get userId => _userId;
  String? get userCoinBalanceId => _userCoinBalanceId;
  String? get amount => _amount;
  String? get currency => _currency;
  String? get trx => _trx;
  String? get finalAmount => _finalAmount;
  String? get status => _status;
  dynamic get adminFeedback => _adminFeedback;
  String? get createdAt => _createdAt;
  UserCoinBalance? get userCoinBalance => _userCoinBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_coin_balance_id'] = _userCoinBalanceId;
    map['amount'] = _amount;
    map['currency'] = _currency;
    map['trx'] = _trx;
    map['final_amount'] = _finalAmount;
    map['status'] = _status;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    if (_userCoinBalance != null) {
      map['user_coin_balance'] = _userCoinBalance?.toJson();
    }
    return map;
  }

}

class UserCoinBalance {
  UserCoinBalance({
      int? id, 
      String? userId, 
      String? minerId, 
      String? wallet, 
      String? balance, 
      Miner? miner,}){
    _id = id;
    _userId = userId;
    _minerId = minerId;
    _wallet = wallet;
    _balance = balance;
    _miner = miner;
}

  UserCoinBalance.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _minerId = json['miner_id'].toString();
    _wallet = json['wallet'].toString();
    _balance = json['balance'].toString();
    _miner = json['miner'] != null ? Miner.fromJson(json['miner']) : null;
  }
  int? _id;
  String? _userId;
  String? _minerId;
  String? _wallet;
  String? _balance;
  Miner? _miner;

  int? get id => _id;
  String? get userId => _userId;
  String? get minerId => _minerId;
  String? get wallet => _wallet;
  String? get balance => _balance;
  Miner? get miner => _miner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['miner_id'] = _minerId;
    map['wallet'] = _wallet;
    map['balance'] = _balance;
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