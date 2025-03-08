import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class HomeRepo{
  ApiClient apiClient;
  HomeRepo({required this.apiClient});

  Future<ResponseModel> getDashboardData()async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.userDashboardEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
   Future<ResponseModel> getUserInfoData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}