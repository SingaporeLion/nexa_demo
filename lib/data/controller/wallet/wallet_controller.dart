import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/authorization/authorization_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/wallet/wallet_response_model.dart';
import 'package:nexa/data/repo/wallet_repo/wallet_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class WalletController extends GetxController{

  WalletRepo walletRepo;
  WalletController({required this.walletRepo});
  bool isLoading = true;
  bool submitLoading = false;
  List<CoinBalances> walletList = [];


  TextEditingController walletAddressController = TextEditingController();

  Future<void> loadWalletData() async{

    isLoading = true;
    update();

    ResponseModel responseModel = await walletRepo.getWalletData();

    walletList.clear();

    if(responseModel.statusCode == 200){

      WalletResponseModel model = WalletResponseModel.fromJson(jsonDecode(responseModel.responseJson));

      if(model.status?.toLowerCase() == "success"){

        List<CoinBalances>? tempCoinBalancesList = model.data?.coinBalances;
        if(tempCoinBalancesList != null && tempCoinBalancesList.isNotEmpty){
          walletList.addAll(tempCoinBalancesList);
        }

      }
      else{
        CustomSnackBar.error(errorList:model.message?.error??[MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();

  }


  Future<void> updateWallet(String minerId) async{



    String walletAddress = walletAddressController.text.toString();

    if(walletAddress.isEmpty){
      CustomSnackBar.error(errorList: [MyStrings.walletAddressEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await walletRepo.updateWalletAddress(minerId, walletAddress);
    if(responseModel.statusCode == 200){
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if(model.status.toString().toLowerCase() == MyStrings.success.toLowerCase()){
           await loadWalletData();
           Get.back();
           walletAddressController.text = '';
           CustomSnackBar.success(successList: model.message?.success??[MyStrings.requestSuccess]);

       } else{
          CustomSnackBar.error(errorList: model.message?.error??[MyStrings.requestFail]);
        }
    }
    else{
        CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }
    submitLoading = false;
    update();
  }


  void setTextFieldData(int index) {
    walletAddressController.text = walletList[index].wallet ?? '';
  }
}