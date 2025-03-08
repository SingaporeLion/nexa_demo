import '../auth/registration_response_model.dart';

class GeneralSettingMainModel {
  GeneralSettingMainModel({
      int? code, 
      String? status, 
      Message? message, 
      Data? data,}){
    _code = code;
    _status = status;
    _message = message;
    _data = data;
}

  GeneralSettingMainModel.fromJson(dynamic json) {
    _code = json['code'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _code;
  String? _status;
  Message? _message;
  Data? _data;

  int? get code => _code;
  String? get status => _status;
  Message? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

  void setCode(int i) {
    _code=i;
  }

}

class Data {
  Data({
      GeneralSetting? generalSetting,}){
    _generalSetting = generalSetting;
}

  Data.fromJson(dynamic json) {
    _generalSetting = json['general_setting'] != null ? GeneralSetting.fromJson(json['general_setting']) : null;
  }
  GeneralSetting? _generalSetting;

  GeneralSetting? get generalSetting => _generalSetting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalSetting != null) {
      map['general_setting'] = _generalSetting?.toJson();
    }
    return map;
  }

}

class GeneralSetting {
  GeneralSetting({
      int? id, 
      String? darkTemplate, 
      dynamic apiToken, 
      String? siteName,
      String? curText, 
      String? curSym, 
      String? emailFrom, 
      String? emailTemplate, 
      String? smsApi, 
      String? baseColor, 
      String? secondaryColor,
      String? securePassword,
      String? agree,
      String? registration,
      String? activeTemplate, 
      String? remainderPlanExpiryDate, 
      dynamic sysVersion, 
      dynamic createdAt, 
      String? updatedAt,}){
    _id = id;
    _darkTemplate = darkTemplate;
    _apiToken = apiToken;
    _siteName = siteName;
    _curText = curText;
    _curSym = curSym;
    _emailFrom = emailFrom;
    _emailTemplate = emailTemplate;
    _smsApi = smsApi;
    _baseColor = baseColor;
    _secondaryColor = secondaryColor;
    _activeTemplate = activeTemplate;
    _remainderPlanExpiryDate = remainderPlanExpiryDate;
    _sysVersion = sysVersion;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  GeneralSetting.fromJson(dynamic json) {
    _id = json['id'];
    _darkTemplate = json['dark_template'].toString();
    _apiToken = json['api_token'].toString();
    _siteName = json['site_name'].toString();
    _curText = json['cur_text'].toString();
    _curSym = json['cur_sym'].toString();
    _emailFrom = json['email_from'].toString();
    _emailTemplate = json['email_template'].toString();
    _smsApi = json['sms_api'].toString();
    _baseColor = json['base_color'].toString();
    _secondaryColor = json['secondary_color'].toString();
    _securePassword = json['secure_password'].toString();
    _agree = json['agree'].toString();
    _registration = json['registration'].toString();
    _activeTemplate = json['active_template'].toString();
    _remainderPlanExpiryDate = json['remainder_plan_expiry_date'].toString();
    _sysVersion = json['sys_version'].toString();
    _createdAt = json['created_at'].toString();
    _updatedAt = json['updated_at'].toString();
  }
  int? _id;
  String? _darkTemplate;
  dynamic _apiToken;
  String? _siteName;
  String? _curText;
  String? _curSym;
  String? _emailFrom;
  String? _emailTemplate;
  String? _smsApi;
  String? _baseColor;
  String? _secondaryColor;
  String? _securePassword;
  String? _agree;
  String? _registration;
  String? _activeTemplate;
  String? _remainderPlanExpiryDate;
  dynamic _sysVersion;
  dynamic _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get darkTemplate => _darkTemplate;
  dynamic get apiToken => _apiToken;
  String? get siteName => _siteName;
  String? get curText => _curText;
  String? get curSym => _curSym;
  String? get emailFrom => _emailFrom;
  String? get emailTemplate => _emailTemplate;
  String? get smsApi => _smsApi;
  String? get baseColor => _baseColor;
  String? get secondaryColor => _secondaryColor;
  String? get securePassword => _securePassword;
  String? get agree => _agree;
  String? get registration => _registration;
  String? get activeTemplate => _activeTemplate;
  String? get remainderPlanExpiryDate => _remainderPlanExpiryDate;
  dynamic get sysVersion => _sysVersion;
  dynamic get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['dark_template'] = _darkTemplate;
    map['api_token'] = _apiToken;
    map['sitename'] = _siteName;
    map['cur_text'] = _curText;
    map['cur_sym'] = _curSym;
    map['email_from'] = _emailFrom;
    map['email_template'] = _emailTemplate;
    map['sms_api'] = _smsApi;
    map['base_color'] = _baseColor;
    map['secondary_color'] = _secondaryColor;
    map['secure_password'] = _securePassword;
    map['agree'] = _agree;
    map['registration'] = _registration;
    map['active_template'] = _activeTemplate;
    map['remainder_plan_expiry_date'] = _remainderPlanExpiryDate;
    map['sys_version'] = _sysVersion;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

