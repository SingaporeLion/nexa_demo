import 'dart:convert';
import 'package:get/get.dart';
import 'package:nexa/data/model/about/privacy_response_model.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/repo/privacy_repo/privacy_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class PrivacyController extends GetxController {
  int selectedIndex = 1;
  PrivacyRepo repo;
  bool isLoading = true;

  List<Policy> list = [];

  late var selectedHtml = '';

  PrivacyController({required this.repo});

  void loadData() async {
    ResponseModel model = await repo.loadAboutData();
    if (model.statusCode == 200) {
      PrivacyResponseModel responseModel = PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.data?.policies != null && responseModel.data!.policies != null && responseModel.data!.policies!.isNotEmpty) {
        
        list.clear();
        list.addAll(responseModel.data!.policies!);
        changeIndex(0);
        updateLoading(false);
      }
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: [model.message], msg: [], isError: false);
      updateLoading(false);
    }
  }

  void changeIndex(int index) {
    selectedIndex = index;
    selectedHtml = list[index].dataValues?.description ?? '';
    update();
  }

  updateLoading(bool status) {
    isLoading = status;
    update();
  }
}
