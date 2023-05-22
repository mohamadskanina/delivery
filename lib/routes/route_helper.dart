import 'package:flutter/cupertino.dart';
import 'package:delivery/pages/address/add_address_page.dart';
import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/food/popular_food_detail.dart';
import 'package:delivery/pages/food/recommended_food_detail.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/pages/splash/splash_page.dart';
import 'package:get/get.dart';
import '../pages/home/home_page.dart';

class RouteHelper {
  static const String splashpage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartpage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";

  static String getSplashPage() => '$splashpage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartpage';
  static String getSignInPage() => '$signIn';
  static String getAddressPage() => '$addAddress';
  static List<GetPage> routes = [
    GetPage(name: splashpage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () {
          return HomePage();
        },
        transition: Transition.fade),
    GetPage(
        name: signIn,
        page: () {
          return SignInPage();
        },
        transition: Transition.fade),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters["page"];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.rightToLeftWithFade),
    GetPage(
        name: cartpage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: addAddress,
        page: () {
          return AddAddressPage();
        }),
  ];
}
