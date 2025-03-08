import '../../auth/registration_response_model.dart';

class BuyPlanSubmitResponseModel {
  BuyPlanSubmitResponseModel({
      String? remark, 
      String? status, 
      Message? message, 
      Data? data,}){
    _remark = remark;
    _status = status;
    _message = message;
    _data = data;
}

  BuyPlanSubmitResponseModel.fromJson(dynamic json) {
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
      String? gatewayUrl, 
      Order? order,}){
    _gatewayUrl = gatewayUrl;
    _order = order;
}

  Data.fromJson(dynamic json) {
    _gatewayUrl = json['gateway_url'];
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
  }
  String? _gatewayUrl;
  Order? _order;

  String? get gatewayUrl => _gatewayUrl;
  Order? get order => _order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gateway_url'] = _gatewayUrl;
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    return map;
  }

}

class Order {
  Order({
      String? orderId,
      String? planTitle, 
      String? amount,}){
    _orderId = orderId;
    _planTitle = planTitle;
    _amount = amount;
}

  Order.fromJson(dynamic json) {
    _orderId = json['order_id'].toString();
    _planTitle = json['plan_title'];
    _amount = json['amount'].toString();
  }
  String? _orderId;
  String? _planTitle;
  String? _amount;

  String? get orderId => _orderId;
  String? get planTitle => _planTitle;
  String? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['plan_title'] = _planTitle;
    map['amount'] = _amount;
    return map;
  }

}
