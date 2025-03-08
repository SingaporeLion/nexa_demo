import '../../auth/registration_response_model.dart';

class ReferralLogResponseModel {
  ReferralLogResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  ReferralLogResponseModel.fromJson(dynamic json) {
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
      Logs? logs,}){
    _logs = logs;
}

  Data.fromJson(dynamic json) {
    _logs = json['logs'] != null ? Logs.fromJson(json['logs']) : null;
  }
  Logs? _logs;

  Logs? get logs => _logs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_logs != null) {
      map['logs'] = _logs?.toJson();
    }
    return map;
  }

}

class Logs {
  Logs({
      List<ReferralData>? data,
      dynamic nextPageUrl, 
      String? path, 
      }){
    _data = data;
    _nextPageUrl = nextPageUrl;
    _path = path;
}

  Logs.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReferralData.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
  }

  List<ReferralData>? _data;
  dynamic _nextPageUrl;
  String? _path;

  List<ReferralData>? get data => _data;
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


class ReferralData {
  ReferralData({
      int? id, 
      String? userId, 
      String? refereeId, 
      String? amount, 
      String? level, 
      String? percent, 
      String? createdAt, 
      dynamic updatedAt, 
      Referee? referee,}){
    _id = id;
    _userId = userId;
    _refereeId = refereeId;
    _amount = amount;
    _level = level;
    _percent = percent;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _referee = referee;
}

  ReferralData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _refereeId = json['referee_id'].toString();
    _amount = json['amount'] !=null? json['amount'].toString():'';
    _level = json['level'] !=null?json['level'].toString():'';
    _percent = json['percent']!=null?json['percent'].toString():'';
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _referee = json['referee'] != null ? Referee.fromJson(json['referee']) : null;
  }
  int? _id;
  String? _userId;
  String? _refereeId;
  String? _amount;
  String? _level;
  String? _percent;
  String? _createdAt;
  dynamic _updatedAt;
  Referee? _referee;

  int? get id => _id;
  String? get userId => _userId;
  String? get refereeId => _refereeId;
  String? get amount => _amount;
  String? get level => _level;
  String? get percent => _percent;
  String? get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;
  Referee? get referee => _referee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['referee_id'] = _refereeId;
    map['amount'] = _amount;
    map['level'] = _level;
    map['percent'] = _percent;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_referee != null) {
      map['referee'] = _referee?.toJson();
    }
    return map;
  }

}

class Referee {
  Referee({
      String? firstname, 
      String? lastname, 
      String? username, 
      String? email, 
     }){
    _firstname = firstname;
    _lastname = lastname;
    _username = username;
    _email = email;
}

  Referee.fromJson(dynamic json) {
    _firstname = json['firstname'].toString();
    _lastname = json['lastname'].toString();
    _username = json['username'].toString();
    _email = json['email'].toString();
  }

  String? _firstname;
  String? _lastname;
  String? _username;
  String? _email;


  String? get firstname => _firstname;
  String? get lastname => _lastname;
  String? get username => _username;
  String? get email => _email;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = _firstname;
    map['lastname'] = _lastname;
    map['username'] = _username;
    map['email'] = _email;
    return map;
  }

}

class Address {
  Address({
      dynamic address, 
      dynamic city, 
      dynamic state, 
      dynamic zip, 
      String? country,}){
    _address = address;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'].toString();
    _state = json['state'].toString();
    _zip = json['zip'].toString();
    _country = json['country'].toString();
  }
  dynamic _address;
  dynamic _city;
  dynamic _state;
  dynamic _zip;
  String? _country;

  dynamic get address => _address;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }

}