import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/services/api_service.dart';

class PrivacyRepo{

  ApiClient apiClient;
  PrivacyRepo({required this.apiClient});

  Future<dynamic>loadAboutData()async{
    String url='${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';
    final response=await apiClient.request(url, Method.getMethod,null);
    return response;
  }

}