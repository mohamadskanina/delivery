import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:delivery/base/no_data_page.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/utils/apps_constants.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../routes/route_helper.dart';

class CartHistory extends StatefulWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  State<CartHistory> createState() => _CartHistoryState();
}

class _CartHistoryState extends State<CartHistory> {
  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;
    Widget TimeWidegt(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Dimensions.height10 * 10,
          color: const Color.fromARGB(255, 213, 178, 143),
          width: double.maxFinite,
          padding: EdgeInsets.only(top: Dimensions.height45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(
                text: "سجل الطلبات ",
                color: Colors.white,
              ),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: Colors.white,
                iconSize: 40,
                backgroundColor: const Color.fromARGB(255, 213, 178, 143),
              )
            ],
          ),
        ),
        GetBuilder<CartController>(builder: (_cartController) {
          return _cartController.getCartHistoryList().length > 0
              ? Expanded(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < cartItemsPerOrder.length; i++)
                                Container(
                                  // height: Dimensions.height30+Dimensions.height30,
                                  //margin: EdgeInsets.only(bottom: Dimensions.height30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TimeWidegt(listCounter),
                                      SizedBox(
                                        height: Dimensions.height20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.height20 *
                                                              4,
                                                      width:
                                                          Dimensions.height10 *
                                                              7.5,
                                                      margin: EdgeInsets.only(
                                                          right: Dimensions
                                                                  .width10 /
                                                              2),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(Dimensions
                                                                      .radius15 /
                                                                  2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(AppConstants
                                                                      .BASE_URL +
                                                                  AppConstants
                                                                      .UPLOAD_URL +
                                                                  getCartHistoryList[
                                                                          listCounter -
                                                                              1]
                                                                      .img!))),
                                                    )
                                                  : Container();
                                            }),
                                          ),
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                    text:
                                                        " عدد طلبات ${itemsPerOrder[i]}",
                                                    color:
                                                        const Color(0xFF5c524f),
                                                    size: Dimensions.font16),
                                                GestureDetector(
                                                  onTap: () {
                                                    var orderTime =
                                                        cartOrderTimeToList();
                                                    Map<int, CartModel>
                                                        moreOrder = {};
                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFF89dad0)),
                                                    ),
                                                    child: SmallText(
                                                      text: "طلب المزيد",
                                                      color: const Color(
                                                          0xFF89dad0),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ))))
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: const NoDataPage(
                    text: "لم شراء أي طلب مسبقاً",
                    imgpath: "assets/image/empty-history.png",
                  ));
        })
      ],
    ));
  }
}
