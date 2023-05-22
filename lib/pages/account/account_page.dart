import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/user_controller.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/account_widgets.dart';
import 'package:delivery/widgets/app_icon.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/location_controllers.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIN = Get.find<AuthController>().userLoggedIN();
    if (_userLoggedIN) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 213, 178, 143),
        title: BigText(
          text: "الملف الشخصي",
          size: 24,
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIN
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        //profile icon
                        AppIcon(
                          icon: Icons.person,
                          backgroundColor: Color.fromARGB(255, 213, 178, 143),
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        ),

                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //name icon
                              AccountWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: Colors.white,
                                    iconColor:
                                        Color.fromARGB(255, 196, 146, 66),
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.name,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //phone icon
                              AccountWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: Colors.white,
                                    iconColor:
                                        Color.fromARGB(255, 196, 146, 66),
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.phone,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //email icon
                              AccountWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.email,
                                    backgroundColor: Colors.white,
                                    iconColor:
                                        Color.fromARGB(255, 196, 146, 66),
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: userController.userModel!.email,
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //address icon
                              GetBuilder<LocationController>(
                                  builder: (locationController) {
                                if (_userLoggedIN &&
                                    locationController.addressList.isEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(
                                          RouteHelper.getAddressPage());
                                    },
                                    child: AccountWidgets(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          backgroundColor: Colors.white,
                                          iconColor:
                                              Color.fromARGB(255, 196, 146, 66),
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                          text: "ادخل عنوانك",
                                        )),
                                  );
                                } else {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidgets(
                                          appIcon: AppIcon(
                                            icon: Icons.location_on,
                                            backgroundColor: Colors.white,
                                            iconColor: Color.fromARGB(
                                                255, 196, 146, 66),
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(
                                            text: "your address",
                                          )));
                                }
                              }),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              //messages icon
                              AccountWidgets(
                                  appIcon: AppIcon(
                                    icon: Icons.message,
                                    backgroundColor: Colors.white,
                                    iconColor:
                                        Color.fromARGB(255, 196, 146, 66),
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                    text: "صندوق الرسائل",
                                  )),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userLoggedIN()) {
                                    Get.find<AuthController>()
                                        .clearSharedData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.offNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: AccountWidgets(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.white,
                                      iconColor:
                                          Color.fromARGB(255, 196, 146, 66),
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                      text: "تسجيل خروج",
                                    )),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimensions.height20 * 15,
                    margin: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/image/app.jpg"))),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      height: Dimensions.height20 * 2,
                      width: Dimensions.width20 * 5 + Dimensions.width20 * 5,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                          top: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(192, 49, 61, 61),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30 * 5),
                      ),
                      child: Center(
                        child: BigText(
                          text: "تسجيل الدخول",
                          color: Colors.white,
                          size: Dimensions.font20,
                        ),
                      ),
                    ),
                  )
                ],
              )));
      }),
    );
  }
}
