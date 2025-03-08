import 'dart:convert';
import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/authorization/authorization_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class SmsEmailVerificationRepo {
  ApiClient apiClient;

  SmsEmailVerificationRepo({required this.apiClient});

  Future<ResponseModel> verify(String code, {bool isEmail = true, bool isTFA = false}) async {
    final map = {
      'code': code,
    };

    String url = '${UrlContainer.baseUrl}${isEmail ? UrlContainer.verifyEmailEndPoint : UrlContainer.verifySmsEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.postMethod, map, passHeader: true);

    return responseModel;
  }


    Future<ResponseModel> sendAuthorizationRequest() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.authorizationCodeEndPoint}';
    ResponseModel responseModel = await apiClient.request(url, Method.getMethod, null, passHeader: true);
    return responseModel;
  }

  Future<bool> resendVerifyCode({required bool isEmail}) async {
    final url = '${UrlContainer.baseUrl}${UrlContainer.resendVerifyCodeEndPoint}${isEmail ? 'email' : 'mobile'}';

    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: true);


    if (response.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
          jsonDecode(response.responseJson));

      if (model.status == 'error') {
        CustomSnackBar.showCustomSnackBar(
            errorList: model.message?.error ?? [MyStrings.resendCodeFail],
            msg: [],
            isError: true);
        return false;
      } else {
        CustomSnackBar.showCustomSnackBar(
            errorList:[''] ,
            msg: model.message?.success ?? [MyStrings.successfullyCodeResend],
            isError: false);
        return true;
      }
    } else {
      return false;
    }
  }
}
