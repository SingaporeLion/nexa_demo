import '../../auth/registration_response_model.dart';

class PlanPaymentMethodResponseModel {
  PlanPaymentMethodResponseModel({
      String? remark, 
      Message? message, 
      Data? data}){
    _remark = remark;
    _message = message;
    _data = data;
}

  PlanPaymentMethodResponseModel.fromJson(dynamic json) {
    _remark  = json['remark'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data    = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _remark;
  Message? _message;
  Data? _data;

  String? get remark => _remark;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
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
      Order? order, 
      List<Methods>? methods,}){
    _order = order;
    _methods = methods;
}

  Data.fromJson(dynamic json) {
    _order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['methods'] != null) {
      _methods = [];
      json['methods'].forEach((v) {
        _methods?.add(Methods.fromJson(v));
      });
    }
  }
  Order? _order;
  List<Methods>? _methods;

  Order? get order => _order;
  List<Methods>? get methods => _methods;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_order != null) {
      map['order'] = _order?.toJson();
    }
    if (_methods != null) {
      map['methods'] = _methods?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Methods {
  Methods({
      int? id, 
      String? name, 
      String? currency, 
      String? symbol, 
      String? methodCode,
      String? gatewayAlias, 
      String? minAmount, 
      String? maxAmount, 
      String? percentCharge, 
      String? fixedCharge, 
      String? rate, 
      dynamic image, 
      String? gatewayParameter, 
      String? createdAt, 
      String? updatedAt, 
      Method? method,}){
    _id = id;
    _name = name;
    _currency = currency;
    _symbol = symbol;
    _methodCode = methodCode;
    _gatewayAlias = gatewayAlias;
    _minAmount = minAmount;
    _maxAmount = maxAmount;
    _percentCharge = percentCharge;
    _fixedCharge = fixedCharge;
    _rate = rate;
    _image = image;
    _gatewayParameter = gatewayParameter;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _method = method;
}

  Methods.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'].toString();
    _currency = json['currency'].toString();
    _symbol = json['symbol'].toString();
    _methodCode = json['method_code'].toString();
    _gatewayAlias = json['gateway_alias'].toString();
    _minAmount = json['min_amount'].toString();
    _maxAmount = json['max_amount'].toString();
    _percentCharge = json['percent_charge'].toString();
    _fixedCharge = json['fixed_charge']!=null?json['fixed_charge'].toString():'0';
    _rate = json['rate'].toString();
    _image = json['image'];
    _gatewayParameter = json['gateway_parameter'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
  }
  int? _id;
  String? _name;
  String? _currency;
  String? _symbol;
  String? _methodCode;
  String? _gatewayAlias;
  String? _minAmount;
  String? _maxAmount;
  String? _percentCharge;
  String? _fixedCharge;
  String? _rate;
  dynamic _image;
  String? _gatewayParameter;
  String? _createdAt;
  String? _updatedAt;
  Method? _method;

  int? get id => _id;
  String? get name => _name;
  String? get currency => _currency;
  String? get symbol => _symbol;
  String? get methodCode => _methodCode;
  String? get gatewayAlias => _gatewayAlias;
  String? get minAmount => _minAmount;
  String? get maxAmount => _maxAmount;
  String? get percentCharge => _percentCharge;
  String? get fixedCharge => _fixedCharge;
  String? get rate => _rate;
  dynamic get image => _image;
  String? get gatewayParameter => _gatewayParameter;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Method? get method => _method;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['currency'] = _currency;
    map['symbol'] = _symbol;
    map['method_code'] = _methodCode;
    map['gateway_alias'] = _gatewayAlias;
    map['min_amount'] = _minAmount;
    map['max_amount'] = _maxAmount;
    map['percent_charge'] = _percentCharge;
    map['fixed_charge'] = _fixedCharge;
    map['rate'] = _rate;
    map['image'] = _image;
    map['gateway_parameter'] = _gatewayParameter;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    return map;
  }

}

class Method {
  Method({
      int? id, 
      String? formId,
      String? code, 
      String? name, 
      String? alias, 
      String? status,
      String? gatewayParameters,
      String? crypto,
      dynamic extra, 
      dynamic description, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _formId = formId;
    _code = code;
    _name = name;
    _alias = alias;
    _status = status;
    _gatewayParameters = gatewayParameters;
    _crypto = crypto;
    _extra = extra;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Method.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'].toString();
    _code = json['code'].toString();
    _name = json['name'].toString();
    _alias = json['alias'].toString();
    _status = json['status'].toString();
    _gatewayParameters = json['gateway_parameters'].toString();
    _crypto = json['crypto'].toString();
    _extra = json['extra'].toString();
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _formId;
  String? _code;
  String? _name;
  String? _alias;
  String? _status;
  String? _gatewayParameters;
  String? _crypto;
  dynamic _extra;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get formId => _formId;
  String? get code => _code;
  String? get name => _name;
  String? get alias => _alias;
  String? get status => _status;
  String? get gatewayParameters => _gatewayParameters;
  String? get crypto => _crypto;
  dynamic get extra => _extra;
  dynamic get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['code'] = _code;
    map['name'] = _name;
    map['alias'] = _alias;
    map['status'] = _status;
    map['gateway_parameters'] = _gatewayParameters;
    map['crypto'] = _crypto;
    map['extra'] = _extra;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Order {
  Order({
      int? id, 
      String? amount, 
      String? planTitle,}){
    _id = id;
    _amount = amount;
    _planTitle = planTitle;
}

  Order.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'].toString();
    _planTitle = json['plan_title'].toString();
  }
  int? _id;
  String? _amount;
  String? _planTitle;

  int? get id => _id;
  String? get amount => _amount;
  String? get planTitle => _planTitle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['plan_title'] = _planTitle;
    return map;
  }

}