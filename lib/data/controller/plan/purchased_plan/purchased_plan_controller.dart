import 'dart:convert';

import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/plan/purchased_plan/purchased_plan_response_model.dart';
import 'package:nexa/data/repo/plan/purchased_plan/purchased_plan_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class PurchasedPlanController extends GetxController{
  PurchasedPlanRepo purchasedPlanRepo;
  PurchasedPlanController({required this.purchasedPlanRepo});

  bool isLoading = true;

  List<PurchasedPlanData> purchasedPlanList = [];
  int page = 0;
  String? nextPageUrl;

  String currencySymbol = '';
  String currency = '';


  void initData() async{
    page = 0;
    purchasedPlanList.clear();
    isLoading = true;
    update();
    await loadPurchasedPlanData();
    isLoading = false;
    update();
  }

  void loadPaginationData() async{
    await loadPurchasedPlanData();
    update();
  }

  /// purchased plan log
  Future<void> loadPurchasedPlanData() async{

    currencySymbol = purchasedPlanRepo.apiClient.getCurrencyOrUsername(isCurrency:true,isSymbol: true);
    currency = purchasedPlanRepo.apiClient.getCurrencyOrUsername(isCurrency:true,isSymbol: false);

    page = page + 1;
    if(page == 1){
      purchasedPlanList.clear();
    }

    ResponseModel responseModel = await purchasedPlanRepo.getPurchasedPlanData(page);
    if(responseModel.statusCode == 200){
      PurchasedPlanResponseModel model = PurchasedPlanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.orders?.nextPageUrl;
      if(model.status.toString().toLowerCase() == "success"){
        List<PurchasedPlanData>?  tempList = model.data?.orders?.data;
        if(tempList != null && tempList.isNotEmpty){
          purchasedPlanList.addAll(tempList);
        }
      } else{
        CustomSnackBar.showCustomSnackBar(errorList: [], msg: [MyStrings.somethingWentWrong], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }
    update();
  }

  bool hasNext(){
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null'? true : false;
  }




}