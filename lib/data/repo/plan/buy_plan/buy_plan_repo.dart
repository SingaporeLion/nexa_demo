import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class BuyPlanRepo{

  ApiClient apiClient;
  BuyPlanRepo({required this.apiClient});

  Future<ResponseModel> getBuyPlanData() async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.planEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);

    return responseModel;
  }

  Future<ResponseModel> planPurchase({required String planId, required String paymentMethod}) async{

    String url = "${UrlContainer.baseUrl}${UrlContainer.planPurchaseEndPoint}";
    Map<String, String> map = {
      "plan_id" : planId,
      "payment_method" : paymentMethod
    };

    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }
}