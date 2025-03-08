import '../auth/registration_response_model.dart';

class PlanPaymentInsertResponseModel {
  PlanPaymentInsertResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  PlanPaymentInsertResponseModel.fromJson(dynamic json) {
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
      Payment? payment, 
      String? redirectUrl,}){
    _payment = payment;
    _redirectUrl = redirectUrl;
}

  Data.fromJson(dynamic json) {
    _payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    _redirectUrl = json['redirect_url'];
  }
  Payment? _payment;
  String? _redirectUrl;

  Payment? get payment => _payment;
  String? get redirectUrl => _redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_payment != null) {
      map['payment'] = _payment?.toJson();
    }
    map['redirect_url'] = _redirectUrl;
    return map;
  }

}

class Payment {
  Payment({
      String? orderId,
      String? userId,
      String? methodCode,
      String? methodCurrency, 
      String? amount, 
      String? charge,
      String? rate, 
      String? finalAmo,
      String? btcAmo,
      String? btcWallet, 
      String? trx, 
      String? updatedAt, 
      String? createdAt, 
      int? id,}){
    _orderId = orderId;
    _userId = userId;
    _methodCode = methodCode;
    _methodCurrency = methodCurrency;
    _amount = amount;
    _charge = charge;
    _rate = rate;
    _finalAmo = finalAmo;
    _btcAmo = btcAmo;
    _btcWallet = btcWallet;
    _trx = trx;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
}

  Payment.fromJson(dynamic json) {
    _orderId        = json['order_id'] !=null? json['order_id'].toString():'';
    _userId         = json['user_id'] !=null? json['user_idString'].toString():'';
    _methodCode     = json['method_code'] !=null? json['method_code'].toString():'0';
    _methodCurrency = json['method_currency'] !=null? json['method_currency'].toString():'0';
    _amount         = json['amount']!=null? json['amount'].toString():'';
    _charge         = json['charge']!=null? json['charge'].toString():'';
    _rate           = json['rate']!=null? json['rate'].toString():'';
    _finalAmo       = json['final_amo']!=null? json['final_amo'].toString():'';
    _btcAmo         = json['btc_amo']!=null? json['btc_amo'].toString():'';
    _btcWallet      = json['btc_wallet']!=null? json['btc_wallet'].toString():'';
    _trx            = json['trx']!=null? json['trx'].toString():'';
    _updatedAt      = json['updated_at'];
    _createdAt      = json['created_at'];
    _id             = json['id'];
  }
  String? _orderId;
  String? _userId;
  String? _methodCode;
  String? _methodCurrency;
  String? _amount;
  String? _charge;
  String? _rate;
  String? _finalAmo;
  String? _btcAmo;
  String? _btcWallet;
  String? _trx;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  String? get orderId => _orderId;
  String? get userId => _userId;
  String? get methodCode => _methodCode;
  String? get methodCurrency => _methodCurrency;
  String? get amount => _amount;
  String? get charge => _charge;
  String? get rate => _rate;
  String? get finalAmo => _finalAmo;
  String? get btcAmo => _btcAmo;
  String? get btcWallet => _btcWallet;
  String? get trx => _trx;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['user_id'] = _userId;
    map['method_code'] = _methodCode;
    map['method_currency'] = _methodCurrency;
    map['amount'] = _amount;
    map['charge'] = _charge;
    map['rate'] = _rate;
    map['final_amo'] = _finalAmo;
    map['btc_amo'] = _btcAmo;
    map['btc_wallet'] = _btcWallet;
    map['trx'] = _trx;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    return map;
  }

}