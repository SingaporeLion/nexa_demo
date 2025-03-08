import 'package:nexa/data/model/auth/registration_response_model.dart';

class MiningTrackResponseModel {
  MiningTrackResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  MiningTrackResponseModel.fromJson(dynamic json) {
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
      Orders? orders,}){
    _orders = orders;
}

  Data.fromJson(dynamic json) {
    _orders = json['orders'] != null ? Orders.fromJson(json['orders']) : null;
  }
  Orders? _orders;

  Orders? get orders => _orders;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orders != null) {
      map['orders'] = _orders?.toJson();
    }
    return map;
  }

}

class Orders {
  Orders({
      List<MiningTrackData>? data,
      String? nextPageUrl, 
      String? path,
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Orders.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MiningTrackData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<MiningTrackData>? _data;
  String? _nextPageUrl;
  String? _path;


  List<MiningTrackData>? get data => _data;
  String? get nextPageUrl => _nextPageUrl;
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
    _label = json['label'];
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

class MiningTrackData {
  MiningTrackData({
      int? id, 
      String? trx, 
      String? userId,
      String? minerId,
      PlanDetails? planDetails, 
      String? amount, 
      String? minReturnPerDay, 
      String? maxReturnPerDay, 
      String? period,
      String? periodRemain,
      String? status,
      String? lastPaid, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _trx = trx;
    _userId = userId;
    _minerId = minerId;
    _planDetails = planDetails;
    _amount = amount;
    _minReturnPerDay = minReturnPerDay;
    _maxReturnPerDay = maxReturnPerDay;
    _period = period;
    _periodRemain = periodRemain;
    _status = status;
    _lastPaid = lastPaid;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  MiningTrackData.fromJson(dynamic json) {
    _id = json['id'];
    _trx = json['trx'].toString();
    _userId = json['user_id'].toString();
    _minerId = json['miner_id'].toString();
    _planDetails = json['plan_details'] != null ? PlanDetails.fromJson(json['plan_details']) : null;
    _amount = json['amount'].toString();
    _minReturnPerDay = json['min_return_per_day'].toString();
    _maxReturnPerDay = json['max_return_per_day'].toString();
    _period = json['period'].toString();
    _periodRemain = json['period_remain'].toString();
    _status = json['status'].toString();
    _lastPaid = json['last_paid'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _trx;
  String? _userId;
  String? _minerId;
  PlanDetails? _planDetails;
  String? _amount;
  String? _minReturnPerDay;
  String? _maxReturnPerDay;
  String? _period;
  String? _periodRemain;
  String? _status;
  String? _lastPaid;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get trx => _trx;
  String? get userId => _userId;
  String? get minerId => _minerId;
  PlanDetails? get planDetails => _planDetails;
  String? get amount => _amount;
  String? get minReturnPerDay => _minReturnPerDay;
  String? get maxReturnPerDay => _maxReturnPerDay;
  String? get period => _period;
  String? get periodRemain => _periodRemain;
  String? get status => _status;
  String? get lastPaid => _lastPaid;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['trx'] = _trx;
    map['user_id'] = _userId;
    map['miner_id'] = _minerId;
    if (_planDetails != null) {
      map['plan_details'] = _planDetails?.toJson();
    }
    map['amount'] = _amount;
    map['min_return_per_day'] = _minReturnPerDay;
    map['max_return_per_day'] = _maxReturnPerDay;
    map['period'] = _period;
    map['period_remain'] = _periodRemain;
    map['status'] = _status;
    map['last_paid'] = _lastPaid;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class PlanDetails {
  PlanDetails({
      String? title, 
      String? miner, 
      String? speed, 
      String? period, 
      String? periodValue,
      String? periodUnit,}){
    _title = title;
    _miner = miner;
    _speed = speed;
    _period = period;
    _periodValue = periodValue;
    _periodUnit = periodUnit;
}

  PlanDetails.fromJson(dynamic json) {
    _title = json['title'].toString();
    _miner = json['miner']!=null?json['miner'].toString():'';
    _speed = json['speed']!=null?json['speed'].toString():'';
    _period = json['period']!=null?json['period'].toString():'';
    _periodValue = json['period_value']!=null?json['period_value'].toString():'';
    _periodUnit = json['period_unit']!=null?json['period_unit'].toString():'';
  }
  String? _title;
  String? _miner;
  String? _speed;
  String? _period;
  String? _periodValue;
  String? _periodUnit;

  String? get title => _title;
  String? get miner => _miner;
  String? get speed => _speed;
  String? get period => _period;
  String? get periodValue => _periodValue;
  String? get periodUnit => _periodUnit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['miner'] = _miner;
    map['speed'] = _speed;
    map['period'] = _period;
    map['period_value'] = _periodValue;
    map['period_unit'] = _periodUnit;
    return map;
  }

}