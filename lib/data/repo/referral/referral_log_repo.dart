import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class ReferralLogRepo{

  ApiClient apiClient;
  ReferralLogRepo({required this.apiClient});

  Future<ResponseModel> getReferralLogData(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.referralLogEndPoint}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }
}