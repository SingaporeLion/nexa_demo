import 'dart:convert';

import 'package:get/get.dart';
import 'package:nexa/core/helper/string_format_helper.dart';
import 'package:nexa/core/route/route.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/plan/plan_payment_insert_response_model.dart';
import 'package:nexa/data/model/plan/plan_payment_method/plan_payment_method_response_model.dart';
import 'package:nexa/data/repo/plan/purchased_plan/purchased_plan_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class PlanPaymentMethodController extends GetxController {
  PurchasedPlanRepo purchasedPlanRepo;
  PlanPaymentMethodController({required this.purchasedPlanRepo, required this.amount});

  bool isLoading = true;

  List<Methods> methodList = [];

  String selectedValue = "";

  String depositLimit = "";
  String charge = "";
  String payable = "";
  String amount = "";
  String fixedCharge = "";
  String currency = '';
  String payableText = '';
  String conversionRate = '';
  String inLocal = '';
  String? nextPageUrl;
  String? crypto;

  String currencySymbol = '';

  Methods? paymentMethod = Methods(name: MyStrings.selectOne, id: -1);
  PlanPaymentMethodResponseModel planPaymentMethodResponseModel = PlanPaymentMethodResponseModel();
  List<Methods> paymentMethodList = [];

  double rate = 1;
  double mainAmount = 0;
  setPaymentMethod(Methods? methods) {
    paymentMethod = methods;
    mainAmount = amount.isEmpty ? 0 : double.tryParse(amount) ?? 0;
    depositLimit = '${MyConverter.twoDecimalPlaceFixedWithoutRounding(paymentMethod?.minAmount?.toString() ?? '0')} - ${MyConverter.twoDecimalPlaceFixedWithoutRounding(paymentMethod?.maxAmount?.toString() ?? '0')} $currency';
    changeInfoWidgetValue(mainAmount);
    update();
  }

  void changeInfoWidgetValue(double amount) {
    if (paymentMethod?.id.toString() == '-1') {
      return;
    }
    mainAmount = amount;
    double percent = double.tryParse(paymentMethod?.percentCharge ?? '0') ?? 0;
    double percentCharge = (amount * percent) / 100;
    double temCharge = double.tryParse(paymentMethod?.fixedCharge ?? '0') ?? 0;
    double totalCharge = percentCharge + temCharge;
    charge = '${MyConverter.twoDecimalPlaceFixedWithoutRounding('$totalCharge')} $currency';
    double payable = totalCharge + amount;
    payableText = '${MyConverter.twoDecimalPlaceFixedWithoutRounding('$payable', precision: 8)} $currency';

    rate = double.tryParse(paymentMethod?.rate ?? '0') ?? 0;
    conversionRate = '1 $currency = $rate ${paymentMethod?.currency ?? ''}';
    inLocal = MyConverter.twoDecimalPlaceFixedWithoutRounding('${payable * rate}');
    update();
    return;
  }

  bool isShowRate() {
    if (rate > 1 && currency.toLowerCase() != paymentMethod?.currency?.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }

  beforeInitLoadData() async {
    currency = purchasedPlanRepo.apiClient.getCurrencyOrUsername();
    isLoading = true;
    update();

    planPaymentMethodResponseModel = await purchasedPlanRepo.getPlanPaymentMethod();
    paymentMethodList.clear();
    paymentMethodList.add(Methods(name: MyStrings.selectOne, id: -1));

    if (planPaymentMethodResponseModel.message != null && planPaymentMethodResponseModel.message?.success != null) {
      List<Methods>? tempPaymentMethodList = planPaymentMethodResponseModel.data?.methods;
      if (tempPaymentMethodList != null || (tempPaymentMethodList == [])) {
        paymentMethodList.addAll(tempPaymentMethodList!);
      }
     
      if (paymentMethodList.isNotEmpty) {
        paymentMethod = paymentMethodList[0];
      }
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  bool isSubmitLoading = false;
  Future<void> submitPayment({required String amount, required String orderId}) async {
    if (paymentMethod?.id.toString() == '-1') {
      CustomSnackBar.error(errorList: [MyStrings.selectAGateway]);
      return;
    }

    isSubmitLoading = true;
    update();
    print("this is order id${orderId}");
    print("this is amount${amount}");
    print("this is order methodCode${paymentMethod?.methodCode ?? ""}");
    print("this is order currency${paymentMethod?.currency ?? ""}");
    ResponseModel responseModel = await purchasedPlanRepo.insertPayment(order: orderId, amount: amount, methodCode: paymentMethod?.methodCode ?? "", currency: paymentMethod?.currency ?? "");

    if (responseModel.statusCode == 200) {
      PlanPaymentInsertResponseModel insertResponseModel = PlanPaymentInsertResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      
      if (insertResponseModel.status.toString().toLowerCase() == "success") {
        showWebView(insertResponseModel.data?.redirectUrl ?? "");
      } else {
        CustomSnackBar.showCustomSnackBar(errorList: [insertResponseModel.message?.error.toString() ?? "Try again"], msg: [], isError: true);
      }
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: [], msg: ["Response Error"], isError: true);
    }
    isSubmitLoading = false;
    update();
  }

  void showWebView(String redirectUrl) {
    Get.offAndToNamed(RouteHelper.depositWebScreen, arguments: redirectUrl);
  }
}
