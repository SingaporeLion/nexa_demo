import 'dart:convert';
import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/authorization/authorization_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class ChangePasswordRepo {
 ApiClient apiClient;

 ChangePasswordRepo({required this.apiClient});

 String token = '', tokenType = '';

 Future<bool> changePassword(String currentPass, String password) async {
  final params = modelToMap(currentPass, password);
  String url = '${UrlContainer.baseUrl}${UrlContainer.changePasswordEndPoint}';

  ResponseModel responseModel = await apiClient
      .request(url, Method.postMethod, params, passHeader: true);

  if (responseModel.statusCode == 200) {
   AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(
       jsonDecode(responseModel.responseJson));
   if (model.status?.toLowerCase() == 'success') {
    CustomSnackBar.showCustomSnackBar(errorList: [], msg: model.message?.success ?? [MyStrings.requestSuccess], isError: false);
    return true;
   } else {
    CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.requestFail], msg: [], isError: true);
    return false;
   }
  } else {
   return false;
  }
 }

 modelToMap(String currentPassword, String newPass) {
  Map<String, dynamic> map2 = {
   'current_password' : currentPassword,
   'password' : newPass,
   'password_confirmation' : newPass
  };
  return map2;
 }
}