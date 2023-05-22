import 'package:get/get.dart';
import '../../utils/apps_constants.dart';
import '../api/api_client.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async
  {
    return await apiClient.getData(AppConstants.POPULAR_PRODACT_URL);
  }
}