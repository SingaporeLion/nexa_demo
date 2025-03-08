import 'dart:convert';

import 'package:get/get.dart';
import 'package:nexa/core/helper/share_preference_helper.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/account/profile_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/home/home_response_model.dart';
import 'package:nexa/data/repo/bottom_nav/home/home_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  bool isLoading = true;
  String isKycVerified = '1';
  List<Miners> minersList = [];
  List<Transactions> transactionList = [];

  String balance = "";
  String referralBonus = "";

  String currencySymbol = '';
  String currency = '';
  String imagePath = "";
  String referralLink = "";

  String rejected = "";
  String pending = "";
  String approved = "";
  String unpaid = "";

  Future<void> loadDashboardData() async {
    currency = homeRepo.apiClient.getCurrencyOrUsername();
    ResponseModel responseModel = await homeRepo.getDashboardData();

    transactionList.clear();

    if (responseModel.statusCode == 200) {
      HomeResponseModel model = HomeResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if (model.status.toString().toLowerCase() == "success") {
        List<Transactions>? tempTransactionList = model.data?.transactions;
        balance = "${MyConverter.twoDecimalPlaceFixedWithoutRounding(model.data?.widget?.balance ?? "")} $currency";
        referralLink = model.data?.referralLink ?? "";
        referralBonus = "${MyConverter.twoDecimalPlaceFixedWithoutRounding(model.data?.widget?.referralBonus ?? "")} $currency";
        imagePath = "${model.data?.coinImagePath ?? ""}/";

        rejected = model.data?.plan?.rejected ?? "0";
        approved = model.data?.plan?.approved ?? "0";
        pending = model.data?.plan?.pending ?? "0";
        unpaid = model.data?.plan?.unpaid ?? "0";

        if (tempTransactionList != null && tempTransactionList.isNotEmpty) {
          transactionList.addAll(tempTransactionList);
        }

        List<Miners>? tempMinersList = model.data?.miners;
        if (tempMinersList != null && tempMinersList.isNotEmpty) {
          minersList.addAll(tempMinersList);
        }
      } else {
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }

    isLoading = false;
    update();
  }

  changeStatusColor(String string, int index) {
    String trxType = transactionList[index].trxType ?? "";
    return trxType == "+" ? MyColor.primaryColor : MyColor.colorRed;
  }

  Future<void> loadUserProfileData() async {
    try {
      ResponseModel responseModel = await homeRepo.getUserInfoData();

      if (responseModel.statusCode == 200) {
        ProfileResponseModel model = ProfileResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status == 'success') {
          await homeRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userPhoneNumberKey, model.data?.user?.mobile ?? '');
          await homeRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userNameKey, model.data?.user?.username ?? '');
          await homeRepo.apiClient.sharedPreferences.setString(SharedPreferenceHelper.userEmailKey, model.data?.user?.email ?? '');
          isKycVerified = model.data?.user?.kv ?? '1';
        } else {}
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }
}
