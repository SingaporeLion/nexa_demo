import 'dart:convert';

import 'package:nexa/core/utils/method.dart' as method;
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/plan/plan_payment_method/plan_payment_method_response_model.dart';
import 'package:nexa/data/model/plan/purchased_plan/purchased_plan_response_model.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class PurchasedPlanRepo{

  ApiClient apiClient;
  PurchasedPlanRepo({required this.apiClient});


  Future<ResponseModel> getPurchasedPlanData(int page) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.purchasedPlanEndPoint}?page=$page";
    ResponseModel responseModel = await apiClient.request(url, method.Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<dynamic> getPlanPaymentMethod() async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.planPaymentMethodEndPoint}";
    ResponseModel responseModel = await apiClient.request(url, method.Method.getMethod, null, passHeader: true);

    if(responseModel.statusCode == 200){
      PlanPaymentMethodResponseModel model = PlanPaymentMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.message?.success != null){
        return model;
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error??['Unknown Validation Error'], msg: [], isError: true);
        return model;
      }
    }
    else{
      return PurchasedPlanResponseModel();
    }
  }

  Future<ResponseModel> insertPayment({required String order, required String amount, required String methodCode, required String currency}) async{
    String url = "${UrlContainer.baseUrl}${UrlContainer.planPaymentInsertEndPoint}";
    Map<String, String> map = {
      "order" : order,
      "amount" : amount,
      "method_code": methodCode,
      "currency": currency
    };
    ResponseModel responseModel = await apiClient.request(url, method.Method.postMethod, map, passHeader: true);
    return responseModel;
  }
}