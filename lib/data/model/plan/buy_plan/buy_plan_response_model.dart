import '../../auth/registration_response_model.dart';

class BuyPlanResponseModel {
  BuyPlanResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  BuyPlanResponseModel.fromJson(dynamic json) {
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
      List<Miners>? miners,}){
    _miners = miners;
}

  Data.fromJson(dynamic json) {
    if (json['miners'] != null) {
      _miners = [];
      json['miners'].forEach((v) {
        _miners?.add(Miners.fromJson(v));
      });
    }
  }
  List<Miners>? _miners;

  List<Miners>? get miners => _miners;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_miners != null) {
      map['miners'] = _miners?.map((v) => v.toJson()).toList();
    }
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
      List<ActivePlans>? activePlans,}){
    _id = id;
    _name = name;
    _coinCode = coinCode;
    _coinImage = coinImage;
    _minWithdrawLimit = minWithdrawLimit;
    _maxWithdrawLimit = maxWithdrawLimit;
    _activePlans = activePlans;
}

  Miners.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _coinCode = json['coin_code'].toString();
    _coinImage = json['coin_image'].toString();
    _minWithdrawLimit = json['min_withdraw_limit'].toString();
    _maxWithdrawLimit = json['max_withdraw_limit'].toString();
    if (json['active_plans'] != null) {
      _activePlans = [];
      json['active_plans'].forEach((v) {
        _activePlans?.add(ActivePlans.fromJson(v));
      });
    }
  }
  int? _id;
  String? _name;
  String? _coinCode;
  String? _coinImage;
  String? _minWithdrawLimit;
  String? _maxWithdrawLimit;
  List<ActivePlans>? _activePlans;

  int? get id => _id;
  String? get name => _name;
  String? get coinCode => _coinCode;
  String? get coinImage => _coinImage;
  String? get minWithdrawLimit => _minWithdrawLimit;
  String? get maxWithdrawLimit => _maxWithdrawLimit;
  List<ActivePlans>? get activePlans => _activePlans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['coin_code'] = _coinCode;
    map['coin_image'] = _coinImage;
    map['min_withdraw_limit'] = _minWithdrawLimit;
    map['max_withdraw_limit'] = _maxWithdrawLimit;
    if (_activePlans != null) {
      map['active_plans'] = _activePlans?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ActivePlans {
  ActivePlans({
      int? id, 
      String? minerId,
      String? title, 
      String? price, 
      String? speed, 
      String? speedUnit,
      dynamic description, 
      String? status,
      String? period,
      String? periodUnit,
      String? minReturnPerDay, 
      String? maxReturnPerDay, 
      List<String>? features,}){
    _id = id;
    _minerId = minerId;
    _title = title;
    _price = price;
    _speed = speed;
    _speedUnit = speedUnit;
    _description = description;
    _status = status;
    _period = period;
    _periodUnit = periodUnit;
    _minReturnPerDay = minReturnPerDay;
    _maxReturnPerDay = maxReturnPerDay;
    _features = features;
}

  ActivePlans.fromJson(dynamic json) {
    _id = json['id'];
    _minerId = json['miner_id'].toString();
    _title = json['title'].toString();
    _price = json['price'].toString();
    _speed = json['speed'].toString();
    _speedUnit = json['speed_unit'].toString();
    _description = json['description'].toString();
    _status = json['status'].toString();
    _period = json['period'].toString();
    _periodUnit = json['period_unit'].toString();
    _minReturnPerDay = json['min_return_per_day'].toString();
    _maxReturnPerDay =  json['max_return_per_day'].toString();
    _features = json['features'] != null ? json['features'].cast<String>() : [];
  }
  int? _id;
  String? _minerId;
  String? _title;
  String? _price;
  String? _speed;
  String? _speedUnit;
  dynamic _description;
  String? _status;
  String? _period;
  String? _periodUnit;
  String? _minReturnPerDay;
  String? _maxReturnPerDay;
  List<String>? _features;

  int? get id => _id;
  String? get minerId => _minerId;
  String? get title => _title;
  String? get price => _price;
  String? get speed => _speed;
  String? get speedUnit => _speedUnit;
  dynamic get description => _description;
  String? get status => _status;
  String? get period => _period;
  String? get periodUnit => _periodUnit;
  String? get minReturnPerDay => _minReturnPerDay;
  String? get maxReturnPerDay => _maxReturnPerDay;
  List<String>? get features => _features;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['miner_id'] = _minerId;
    map['title'] = _title;
    map['price'] = _price;
    map['speed'] = _speed;
    map['speed_unit'] = _speedUnit;
    map['description'] = _description;
    map['status'] = _status;
    map['period'] = _period;
    map['period_unit'] = _periodUnit;
    map['min_return_per_day'] = _minReturnPerDay;
    map['max_return_per_day'] = _maxReturnPerDay;
    map['features'] = _features;
    return map;
  }

}