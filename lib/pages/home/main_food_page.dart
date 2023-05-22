import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import 'food_page_body.dart';

class MainFoodpage extends StatefulWidget {
  const MainFoodpage({super.key});
  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  Future<void> _loadResource() async {
    await Get.find<PopulerProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BigText(
                          text: "Bangladesh",
                          color: Color(0xff111111),
                        ),
                        Row(
                          children: [
                            SmallText(
                              text: "Narsingdi",
                              color: Colors.black54,
                            ),
                            Icon(
                              Icons.arrow_drop_down_rounded,
                              color: Color.fromARGB(225, 103, 171, 151),
                            )
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(Icons.search,
                            color: Colors.white, size: Dimensions.iconSize24),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: Color.fromARGB(225, 103, 171, 151),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),
        onRefresh: _loadResource);
  }
}
