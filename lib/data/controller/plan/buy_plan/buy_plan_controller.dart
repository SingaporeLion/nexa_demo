import 'dart:convert';

import 'package:get/get.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/plan/buy_plan/buy_plan_submit_response_model.dart';
import 'package:nexa/data/model/plan/buy_plan/buy_plan_response_model.dart';
import 'package:nexa/data/repo/plan/buy_plan/buy_plan_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class BuyPlanController extends GetxController{

  BuyPlanRepo buyPlanRepo;
  BuyPlanController({required this.buyPlanRepo});

  bool isLoading = true;
  int index = 0;

  List<Miners> walletList = [];
  List<ActivePlans>planList = [];

  List<String> paymentSystemList = ["Select One", "From Balance", "Direct Payment"];
  String selectPaymentSystem = "Select One";

  String currency = "";

  void setPaymentMethod(String value){
    selectPaymentSystem = value;
    update();
  }

  /// load plan
  Future<void> loadBuyPlanData() async{
    walletList.clear();
    currency = buyPlanRepo.apiClient.getCurrencyOrUsername();

    ResponseModel responseModel = await buyPlanRepo.getBuyPlanData();
    if(responseModel.statusCode == 200){
      BuyPlanResponseModel model = BuyPlanResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        List<Miners>? tempWalletList = model.data?.miners;
        tempWalletList?.forEach((element) { element.name.toString(); });
        if(tempWalletList != null && tempWalletList.isNotEmpty){
          walletList.addAll(tempWalletList);
          changeWallet(index);
        }

      }else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }
    isLoading = false;
    update();
  }

  void changeWallet(int index){
    this.index = index;
    planList.clear();
    Miners wallet = walletList[index];
    List<ActivePlans>?tempPlanList = wallet.activePlans;
    if(tempPlanList!=null && tempPlanList.isNotEmpty){
      planList.addAll(tempPlanList);
    }
    selectedIndex = -1;
    update();
  }


  bool purchaseLoading = false;
  Future<void> planPurchase({required int planId, required String paymentMethod}) async{

    purchaseLoading = true;
    update();

    ResponseModel responseModel = await buyPlanRepo.planPurchase(planId: planId.toString(), paymentMethod: paymentMethod.toString());

    if(responseModel.statusCode == 200){
      BuyPlanSubmitResponseModel model = BuyPlanSubmitResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
        Get.back();
        if(paymentMethod.toString()=='1'){
          CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);
        } else{
          String title = model.data?.order?.planTitle??'';
          String amount = model.data?.order?.amount??'';
          String orderId = model.data?.order?.orderId??'';
          Get.toNamed(RouteHelper.planPaymentMethodScreen,arguments: [title,amount,orderId]);
        }

      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.requestFail], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }

    purchaseLoading = false;
    update();
    return ;
  }

  int selectedIndex = -1;
  void changeIndex(int index){
    selectedIndex = index;
    update();
  }
}