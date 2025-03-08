import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/controller/withdraw/show_dialog.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:nexa/data/model/withdraw/withdraw_request_response_model.dart';
import 'package:nexa/data/repo/withdraw_repo/withdraw_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';


class WithdrawMoneyController extends GetxController{

  WithdrawRepo withdrawRepo;
  WithdrawMoneyController({required this.withdrawRepo});

  bool isLoading = true;

  TextEditingController amountController = TextEditingController();

  String currency = '';


  void initData() async{
    currency = withdrawRepo.apiClient.getCurrencyOrUsername();
    methodList.clear();
    isLoading = true;
    update();
    await loadWithdrawMethodData();
    isLoading = false;
    update();
  }

  void clearData(){
    isLoading = true;
    methodList.clear();
    submitLoading = false;
    amountController.text = '';
  }

  List<WithdrawMethod> methodList = [];
  Future<void> loadWithdrawMethodData() async{
    isLoading = true;
    update();

    methodList.clear();

    ResponseModel responseModel = await withdrawRepo.getWithdrawMethodData();
    if(responseModel.statusCode == 200){
      WithdrawMethodResponseModel model = WithdrawMethodResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success){
        List<WithdrawMethod>? tempMethodList = model.data?.withdrawMethod;
        if(tempMethodList != null && tempMethodList.isNotEmpty){
          methodList.addAll(tempMethodList);
        }
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }

    isLoading = false;
    update();

  }


  bool submitLoading = false;
  Future<void> submitWithdraw(int walletId,int index) async{

    String amount = amountController.text.toString();
    if(amount.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.plsEnterAnAmount]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await withdrawRepo.requestWithdraw(walletId: walletId.toString(), amount: amountController.text.toString());

    if(responseModel.statusCode == 200){
      WithdrawRequestResponseModel model = WithdrawRequestResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      if(model.status.toString().toLowerCase() == MyStrings.success){
        Get.back();
        CustomSnackBar.success(successList: [MyStrings.withdrawRequestSuccess]);
        amountController.text = '';
        String cur = methodList[index].miner?.coinCode??'';
        String status = getStatus(model.data?.status??'2');
        
       //show dialog
        PreviewDialog(amount: '${model.data?.amount??''} $cur',trxId: model.data?.trx??'',remBalance:'${model.data?.postBalance??' '} $cur' ,status: status).showMyDialog();
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.requestFail], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }

    submitLoading = false;
    update();
  }


  int selectedIndex = -1;
  void changeIndex(int index){
    selectedIndex = index;
    update();
  }
  
  String getStatus(String status){
    return status == "1" ? MyStrings.approved
        : status == "2" ? MyStrings.pending
        : status == "3" ? MyStrings.rejected
        : "";
  }



}

