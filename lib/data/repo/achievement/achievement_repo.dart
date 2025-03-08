import 'package:nexa/core/utils/method.dart';
import 'package:nexa/core/utils/url_container.dart';
import 'package:nexa/data/model/global/response_model/response_model.dart';
import 'package:nexa/data/services/api_service.dart';

class AchievementRepo {
  final ApiClient apiClient;

  AchievementRepo({required this.apiClient});

  Future<ResponseModel> getAchievement() async {
    return await apiClient.request(UrlContainer.achievementEndPoint, Method.getMethod, null, passHeader: true);
  }
}
