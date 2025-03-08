import 'package:get/get.dart';
import 'package:nexa/data/repo/auth/general_setting_repo.dart';
import 'package:nexa/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences, fenix: true);
  Get.lazyPut(() => ApiClient(sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(() => GeneralSettingRepo(apiClient: Get.find()), fenix: true);
}
