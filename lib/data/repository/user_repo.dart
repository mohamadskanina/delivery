import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/utils/apps_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.USERINFO_URL);
  }
}
