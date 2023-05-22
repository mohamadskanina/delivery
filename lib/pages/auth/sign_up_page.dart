import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:delivery/base/custom_loader.dart';
import 'package:delivery/controllers/auth_controller.dart';
import 'package:delivery/models/signup_body_model.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_text_filed.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../base/show_custom_snackbar.dart';
import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var SignUpImages = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();

      if (name.isEmpty) {
        ShowCustomSnackBar("ادخل الاسم", title: "الاسم");
      } else if (phone.isEmpty) {
        ShowCustomSnackBar(" ادخل رقم الهاتف ", title: "رقم الهاتف");
      } else if (email.isEmpty) {
        ShowCustomSnackBar(" ادخل البريد الإلكتروني ",
            title: "البريد الإلكتروني");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("عنوان البريد خاطىء");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("كلمة المرور", title: "كلمة المرور");
      } else if (password.length < 6) {
        ShowCustomSnackBar("يجب ألاَ تقل كلمة المرور عن ستة محارف",
            title: "كلمة المرور");
      } else {
        ShowCustomSnackBar("تم تسجيل الدخول", title: "رائع");

        SignUpBody signUpBody = SignUpBody(
            password: password, email: email, phone: phone, name: name);

        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
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
                            backgroundImage: AssetImage("assets/image/app.jpg"),
                          ),
                        ),
                      ),
                      //email
                      AppTextFiled(
                        textController: emailController,
                        hintText: "البريد الإلكتروني",
                        icon: Icons.email,
                      ),
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
                      //name
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextFiled(
                          textController: nameController,
                          hintText: "الاسم",
                          icon: Icons.person),
                      //phone
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      AppTextFiled(
                          textController: phoneController,
                          hintText: "الهاتف",
                          icon: Icons.phone),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
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
                        height: Dimensions.height10,
                      ),
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "هل تملك حساب؟",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 103, 102, 102),
                                  fontSize: Dimensions.font20))),
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
                      //sign up option
                      RichText(
                          text: TextSpan(
                              text: "تسجيل الدخول بواسطة:",
                              style: TextStyle(
                                color: Color.fromARGB(255, 103, 102, 102),
                                fontSize: Dimensions.font16,
                              ))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + SignUpImages[index]),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
