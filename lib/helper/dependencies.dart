import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/location_controllers.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/data/api/api_client.dart';
import 'package:delivery/data/repository/auth_repo.dart';
import 'package:delivery/data/repository/cart_repo.dart';
import 'package:delivery/data/repository/location_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/popular_product_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../data/repository/user_repo.dart';
import '../utils/apps_constants.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopulerProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
