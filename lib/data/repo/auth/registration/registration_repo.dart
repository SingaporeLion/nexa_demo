import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';


class RegistrationRepo {
  ApiClient apiClient;

  RegistrationRepo({required this.apiClient});

  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = model.toMap();
    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map,passHeader: true,isOnlyAcceptType: true);
    return responseModel;
  }



  Future<dynamic> getCountryData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}";
    ResponseModel model = await apiClient.request(url, Method.getMethod, null);
    return model;
  }

  Future<bool> sendUserToken() async {
    String deviceToken;
    if (apiClient.sharedPreferences.containsKey(SharedPreferenceHelper.fcmDeviceKey)) {
      deviceToken = apiClient.sharedPreferences.getString(SharedPreferenceHelper.fcmDeviceKey) ?? '';
    } else {
      deviceToken = '';
    }
    bool success = false;
    if (deviceToken.isEmpty) {
    } else {
    }
    return success;
  }

  Future<bool> sendUpdatedToken(String deviceToken) async {
    String url='${UrlContainer.baseUrl}${UrlContainer.deviceTokenEndPoint}';
    Map<String,String>map = deviceTokenMap(deviceToken);
    await apiClient.request(url,Method.postMethod,map,passHeader: true);
    return true;
  }

  Map<String,String> deviceTokenMap(String deviceToken) {
    Map<String, String> map = {'token': deviceToken.toString()};
    return map;
  }

   Future<ResponseModel> socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    Map<String, String>? map;

    if (provider == 'google') {
      map = {'token': accessToken, 'provider': "google"};
    }
    if (provider == 'linkedin') {
      map = {'token': accessToken, 'provider': "linkedin"};
    }

    String url = '${UrlContainer.baseUrl}${UrlContainer.socialLoginEndPoint}';

    ResponseModel model = await apiClient.request(url, Method.postMethod, map, passHeader: false);

    return model;
  }

}