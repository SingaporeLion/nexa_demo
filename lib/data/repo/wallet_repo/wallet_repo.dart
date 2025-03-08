import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class WalletRepo{

  ApiClient apiClient;
  WalletRepo({required this.apiClient});

  Future<ResponseModel> getWalletData() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.walletEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<ResponseModel> updateWalletAddress(String minerId, String walletAddress) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.walletUpdateEndPoint}";
    Map<String, String> map = {
      "id" : minerId,
      "wallet" :walletAddress,
    };
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);
    return responseModel;
  }

}