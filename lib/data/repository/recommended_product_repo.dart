import 'package:get/get.dart';
import '../../utils/apps_constants.dart';
import '../api/api_client.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async
  {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODACT_URL);
  }
}