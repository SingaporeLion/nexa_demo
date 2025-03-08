import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/utils/dimensions.dart';
import 'package:nexa/core/utils/my_color.dart';
import 'package:nexa/core/utils/styles.dart';
import 'package:nexa/data/controller/transaction/transaction_controller.dart';

showTrxBottomSheet(List<String>? list, int callFrom, {required BuildContext context}) {
  if (list != null && list.isNotEmpty) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 5,
                        width: 50,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: MyColor.colorGrey.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.space15),
                    SizedBox(
                      child: ListView.builder(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  String selectedValue = list[index];
                                  final controller = Get.find<TransactionController>();
                                  if (callFrom == 1) {
                                    controller.changeSelectedTrxType(selectedValue);
                                    controller.filterData();
                                  } else if (callFrom == 2) {
                                    controller.changeSelectedRemark(selectedValue);
                                    controller.filterData();
                                  }
                                  Navigator.pop(context);

                                  FocusScopeNode currentFocus = FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: MyColor.screenBgColor.withValues(alpha: .5)),
                                  child: Text(
                                    ' ${callFrom == 2 ? MyConverter.replaceUnderscoreWithSpace(list[index].capitalizeFirst ?? '') : list[index]}',
                                    style: interSemiBoldSmall,
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
          );
        });
  }
}
