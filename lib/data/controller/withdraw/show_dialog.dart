
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/views/screens/bottom_nav_screens/mine/plan_payment_method/custom_row.dart';

class PreviewDialog{

  final String amount;
  final String trxId;
  final String remBalance;
  final String status;


  PreviewDialog({required this.amount, required this.trxId, required this.remBalance, required this.status});

  void  showMyDialog(){
    showDialog(
      context: Get.context!,
      useRootNavigator: false,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
        title: const Text(MyStrings.withdrawPreview),
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: MyColor.screenBgColor)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRow(firstText: MyStrings.amount, lastText: amount),
              CustomRow(firstText: MyStrings.trxID, lastText: trxId),
              CustomRow(firstText: MyStrings.postBalance, lastText: remBalance),
              CustomRow(firstText: MyStrings.status, lastText: status,showDivider: false,),
            ],
          ),
        ),
        actions: _getActionButtons(),
      )
          : AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        titlePadding: const EdgeInsets.all(15),
        titleTextStyle: interSemiBoldLarge.copyWith(fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text(MyStrings.withdrawPreview),
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: MyColor.screenBgColor)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomRow(firstText: MyStrings.amount, lastText: amount),
              CustomRow(firstText: MyStrings.trxID,  lastText: trxId),
              CustomRow(firstText: MyStrings.postBalance, lastText: remBalance),
              CustomRow(firstText: MyStrings.status, lastText: status,showDivider: false,),
            ],
          ),
        ),
        actions: _getActionButtons(),
      ),
    );
  }
}

List<Widget> _getActionButtons() {
  var resultList = <Widget>[];
  if ( Platform.isIOS) {
    resultList.addAll([
      CupertinoDialogAction(
        child: const Text(MyStrings.close),
        onPressed: () {
          Get.back();
        },
      ),
      const SizedBox()
    ]);
  }
  else {
    resultList.addAll([
      TextButton(
        child: const Text(MyStrings.close),
        onPressed: () {
          Get.back();
        },
      ),
      const SizedBox()
    ]);
  }
  return resultList;
}