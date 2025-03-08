import 'dart:convert';

import 'package:get/get.dart';
import 'package:nexa/core/utils/my_strings.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/model/plan/mining_track/mining_track_response_model.dart';
import 'package:nexa/data/repo/plan/mining_track/mining_track_repo.dart';
import 'package:nexa/views/components/snackbar/show_custom_snackbar.dart';

class MiningTracksController extends GetxController {
  MiningTrackRepo miningTrackRepo;
  MiningTracksController({required this.miningTrackRepo});

  bool isLoading = true;
  List<MiningTrackData> miningTrackList = [];

  int page = 0;
  String? nextPageUrl;

  String currency = '';

  void loadPaginationData() async {
    await loadMiningTrackData();
    update();
  }

  void initData() async {
    page = 0;
    miningTrackList.clear();
    isLoading = true;
    update();
    await loadMiningTrackData();
    isLoading = false;
    update();
  }

  Future<void> loadMiningTrackData() async {
    currency = miningTrackRepo.apiClient.getCurrencyOrUsername(isCurrency: true, isSymbol: false);

    page = page + 1;
    if (page == 1) {
      miningTrackList.clear();
    }

    ResponseModel responseModel = await miningTrackRepo.getMiningTracksData(page);
    if (responseModel.statusCode == 200) {
      MiningTrackResponseModel model = MiningTrackResponseModel.fromJson(jsonDecode(responseModel.responseJson));
      nextPageUrl = model.data?.orders?.nextPageUrl;
      if (model.status.toString().toLowerCase() == "success") {
        List<MiningTrackData>? tempMiningList = model.data?.orders?.data;
        if (tempMiningList != null && tempMiningList.isNotEmpty) {
        
          miningTrackList.addAll(tempMiningList);
        }
      } else {
        CustomSnackBar.showCustomSnackBar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackBar.showCustomSnackBar(errorList: [responseModel.message], msg: [], isError: true);
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }
}
