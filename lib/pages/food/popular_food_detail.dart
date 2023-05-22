import 'package:flutter/material.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/utils/apps_constants.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail(
      {super.key, required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopulerProductController>().popularProductList[pageId];
    Get.find<PopulerProductController>()
        .initProduct(product, Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          //icon widgets
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        iconColor: Color.fromARGB(225, 103, 171, 151),
                      )),
                  GetBuilder<PopulerProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            iconColor: Color.fromARGB(225, 103, 171, 151),
                          ),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor:
                                        Color.fromARGB(255, 208, 163, 150),
                                  ),
                                )
                              : Container(),
                          Get.find<PopulerProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 5,
                                  top: 4,
                                  child: BigText(
                                    text: Get.find<PopulerProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      topLeft: Radius.circular(Dimensions.radius20),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "التفاصيل"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description!)))
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopulerProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height10 - 2,
                    bottom: Dimensions.height10 - 2,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: AppIcon(
                              iconColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 208, 163, 150),
                              icon: Icons.remove)),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(
                        text: popularProduct.inCartItems.toString(),
                        size: 20,
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: AppIcon(
                              iconSize: Dimensions.iconSize16,
                              iconColor: Colors.white,
                              backgroundColor:
                                  const Color.fromARGB(255, 208, 163, 150),
                              icon: Icons.add)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height10 / 2,
                        bottom: Dimensions.height10 / 2,
                        left: Dimensions.width10 / 2,
                        right: Dimensions.width10 / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: const Color.fromARGB(225, 103, 171, 151),
                    ),
                    child: BigText(
                      text: " السعر${product.price!}"
                          "*1:"
                          " إضافة إلى السلة ${product.price! * popularProduct.inCartItems}  ",
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
