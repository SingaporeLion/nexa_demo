import 'package:nexa/data/model/auth/registration_response_model.dart';

class WithdrawRequestResponseModel {
  WithdrawRequestResponseModel({
      String? remark, 
      String? status,
      Message? message,
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  WithdrawRequestResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
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
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? amount,
      String? trx,
      String? postBalance,
      String? status,}){
    _amount = amount;
    _trx = trx;
    _postBalance = postBalance;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _amount = json['amount'].toString();
    _trx = json['trx'].toString();
    _postBalance = json['post_balance'].toString();
    _status = json['status'].toString();
  }
  String? _amount;
  String? _trx;
  String? _postBalance;
  String? _status;

  String? get amount => _amount;
  String? get trx => _trx;
  String? get postBalance => _postBalance;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['trx'] = _trx;
    map['post_balance'] = _postBalance;
    map['status'] = _status;
    return map;
  }

}