import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class WithdrawRepo{

  ApiClient apiClient;
  WithdrawRepo({required this.apiClient});

  Future<ResponseModel> getWithdrawHistory(int page, {String searchText = ""}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawLogEndPoint}?page=$page&search=$searchText";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> getWithdrawMethodData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawMethodEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> requestWithdraw({required String walletId, required String amount}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawRequestEndPoint}";
    Map<String, String> map = {
      "wallet_id" : walletId,
      "amount" : amount
    };
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }
}