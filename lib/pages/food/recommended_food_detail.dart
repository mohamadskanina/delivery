import 'package:flutter/material.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';
import 'package:delivery/routes/route_helper.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/apps_constants.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail(
      {Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopulerProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
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
                  child: const AppIcon(
                      icon: Icons.clear,
                      iconColor: Color.fromARGB(255, 66, 133, 132)),
                ),
                GetBuilder<PopulerProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      //if (controller.totalItems >= 1)
                      Get.toNamed(RouteHelper.getCartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconSize: 30,
                          iconColor: Color.fromARGB(225, 103, 171, 151),
                        ),
                        Get.find<PopulerProductController>().totalItems >= 1
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
                                right: 3,
                                top: 0,
                                child: BigText(
                                  text: Get.find<PopulerProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 15,
                                  color: Color.fromARGB(252, 243, 236, 236),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular((Dimensions.radius20)),
                      topRight: Radius.circular((Dimensions.radius20)),
                    )),
                child: Center(
                    child:
                        BigText(size: Dimensions.font26, text: product.name!)),
              ),
            ),
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 208, 163, 150),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: ExpandableTextWidget(text: product.description!),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopulerProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20 * 2.5,
                right: Dimensions.width20 * 2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(false);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor: Color.fromARGB(225, 103, 171, 151),
                          icon: Icons.remove)),
                  BigText(
                    text: " L.T ${product.price!} * ${controller.inCartItems}",
                    color: const Color(0xFF332d2b),
                    size: Dimensions.font26,
                  ),
                  GestureDetector(
                      onTap: () {
                        controller.setQuantity(true);
                      },
                      child: AppIcon(
                          iconSize: Dimensions.iconSize24,
                          iconColor: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(225, 103, 171, 151),
                          icon: Icons.add))
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(
                  top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: const Color(0xFFf7f6f4),
                  borderRadius: BorderRadius.only()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: const Icon(
                        Icons.favorite,
                        color: Color.fromARGB(255, 208, 163, 150),
                      )),
                  GestureDetector(
                    onTap: () {
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: const Color.fromARGB(225, 103, 171, 151),
                      ),
                      child: BigText(
                          text: "إضافة إلى السلة"
                              "  ${product.price! * controller.inCartItems} ",
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
