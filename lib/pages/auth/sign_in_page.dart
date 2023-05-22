import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/pages/auth/sign_up_page.dart';
import 'package:delivery/routes/route_helper.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_text_filed.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      if (phone.isEmpty) {
        ShowCustomSnackBar("ادخل رقم الهاتف ", title: "رقم الهاتف");
      } else if (password.length < 6) {
        ShowCustomSnackBar("يجب ألاَ تقل كلمة المرور عن ستة محارف",
            title: "كلمة المرور");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getCartPage());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),

                        //logo
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/image/app.jpg"),
                            ),
                          ),
                        ),

                        //welcome
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "أهلاً بك ",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "سجل دخولك إلى حسابك ",
                                style: TextStyle(
                                  fontSize: Dimensions.font16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //email
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        AppTextFiled(
                            textController: phoneController,
                            hintText: "رقم الهاتف ",
                            icon: Icons.phone),
                        //password
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AppTextFiled(
                          textController: passwordController,
                          hintText: "كلمة المرور",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            //
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //sign in
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                              width: Dimensions.screenWidth / 2,
                              height: Dimensions.screenWidth / 9,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: Color.fromARGB(192, 49, 61, 61),
                              ),

                              //sign up botton
                              child: Center(
                                child: Container(
                                  child: BigText(
                                    text: "تسجيل الدخول",
                                    size: Dimensions.font20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),

                        //sign up option
                        RichText(
                            text: TextSpan(
                                text: "  لا تملك حساب ؟",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 103, 102, 102),
                                  fontSize: Dimensions.font20,
                                ),
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(
                                          () => SignUpPage(),
                                          transition: Transition.circularReveal,
                                        ),
                                  text: " إنشاء حساب",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: Dimensions.font20,
                                  )),
                            ])),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
