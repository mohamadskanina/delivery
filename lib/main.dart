import 'package:flutter/material.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/pages/auth/sign_up_page.dart';
import 'package:delivery/pages/cart/cart_page.dart';
import 'package:delivery/pages/home/food_page_body.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/pages/splash/splash_page.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
nces/shared_preferences.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartDate();
    return GetBuilder<PopulerProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return  GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food Delivery',
           //  home: SignInPage(),
            // home: SplashScreen(),
           initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
