import 'package:flutter/material.dart';
import 'package:delivery/base/no_data_page.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/location_controllers.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/controllers/recommended_product_controller.dart';
import 'package:delivery/utils/apps_constants.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      size: 50,
                      iconColor: Colors.white,
                      backgroundColor: const Color.fromARGB(225, 103, 171, 151),
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 4,
                  ),
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10,
                          right: Dimensions.width10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Color.fromARGB(225, 103, 171, 151),
                      ),
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        return BigText(
                          text: "الكمية الإجمالية: " +
                              cartController.totalItems.toString(),
                          color: Color.fromARGB(255, 248, 248, 248),
                        );
                      }))
                ],
              )),
          //body
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20 * 6,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                              builder: (CartController) {
                            var _cartList = CartController.getItems;
                            return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: Dimensions.height20 * 6,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var populerIndex = Get.find<
                                                    PopulerProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (populerIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      populerIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History Product",
                                                    "Product review is not found for history Product ",
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            225, 103, 171, 151),
                                                    colorText: const Color(
                                                        0xfff6f6f6));
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          CartController
                                                              .getItems[index]
                                                              .img!,
                                                    )),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: Dimensions.height20 * 5,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: Dimensions.height20 * 7,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(
                                                text: CartController
                                                    .getItems[index].name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: "السعر"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text: CartController
                                                        .getItems[index].price
                                                        .toString(),
                                                    size: 20,
                                                    color: Colors.black,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimensions
                                                                .height10 -
                                                            3,
                                                        bottom:
                                                            Dimensions
                                                                    .height10 -
                                                                3,
                                                        left:
                                                            Dimensions.width10 -
                                                                3,
                                                        right:
                                                            Dimensions.width10 -
                                                                3),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                      color: Color.fromARGB(
                                                          255, 208, 163, 150),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                            onTap: () {
                                                              CartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                              // popularProduct.setQuantity(false);
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white,
                                                            )),

                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                            text:
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                            color: Colors.white,
                                                            size: 20),
                                                        //popularProduct.inCartItems.toString()),
                                                        SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                            onTap: () {
                                                              CartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ))
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  );
                                });
                          }),
                        )))
                : NoDataPage(text: "لم يتم طلب أي منتج بعد");
          })
        ],
      ),
      //bottom bar
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
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
            child: cartController.getItems.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height10,
                            bottom: Dimensions.height10,
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Color.fromARGB(225, 103, 171, 151),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                            BigText(
                              text:
                                  cartController.totalAmount.toString() + "ل.ت",
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: Dimensions.width10 / 2,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Get.find<AuthController>().userLoggedIN()) {
                            print("logged in ?");
                            if (Get.find<LocationController>()
                                .addressList
                                .isEmpty) {
                              Get.toNamed(RouteHelper.getAddressPage());
                            } else {
                              Get.offNamed(RouteHelper.getInitial());
                            }
                          } else {
                            Get.toNamed(RouteHelper.getSignInPage());
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height10,
                              bottom: Dimensions.height10,
                              left: Dimensions.width20 + 5,
                              right: Dimensions.width20 + 5),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Color.fromARGB(225, 103, 171, 151),
                          ),
                          child: BigText(
                            text: "  تأكيد",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                : Container(),
          );
        },
      ),
    );
  }
}
