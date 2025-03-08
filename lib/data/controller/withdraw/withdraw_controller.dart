import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/withdraw/withdraw_response_model.dart';
import 'package:nexa/data/repo/withdraw_repo/withdraw_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class WithdrawController extends GetxController{

  WithdrawRepo withdrawRepo;
  WithdrawController({required this.withdrawRepo});

  bool isLoading = true;
  bool isSubmit = false;

  List<WithdrawData> withdrawList = [];

  int page = 0;
  String? nextPageUrl;
  TextEditingController searchController = TextEditingController();

  String currency = '';
  int index = 0;


  void loadPaginationData() async{
    await loadWithdrawHistory();
    update();
  }


  Future<void> loadWithdrawHistory() async{
    page = page + 1;
    if(page == 1){
      withdrawList.clear();
    }

    String searchText = searchController.text;

    ResponseModel responseModel = await withdrawRepo.getWithdrawHistory(page, searchText: searchText);
    if(responseModel.statusCode == 200){
      WithdrawResponseModel model = WithdrawResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.withdraws?.nextPageUrl;
      if(model.status.toString().toLowerCase() == "success"){
        List<WithdrawData>?  tempWithdrawList = model.data?.withdraws?.data;
        if(tempWithdrawList != null && tempWithdrawList.isNotEmpty){
          withdrawList.addAll(tempWithdrawList);
        }
      }
      else{
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    }
    else{
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }


  bool filterLoading = false;
  Future<void> filterData()async{
    page=0;
    filterLoading = true;
    update();
    await loadWithdrawHistory();

    filterLoading=false;
    update();
  }

  bool hasNext(){
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null'? true : false;
  }

  void initialSelectedValue() async{

    currency = withdrawRepo.apiClient.getCurrencyOrUsername();
    page = 0;
    searchController.text = '';
    withdrawList.clear();
    isLoading = true;
    update();

    await loadWithdrawHistory();
    isLoading = false;
    update();

  }

  bool isSearch = false;
  void changeSearchStatus(){
    isSearch = ! isSearch;
    update();

    if(!isSearch){
      initialSelectedValue();
    }
  }
}