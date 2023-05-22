import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.44;
  static double pageViewContainer = screenHeight / 3.56;
  static double pageViewTextContainer = screenHeight / 6.50;

  static double height10 = screenHeight / 78.1;
  static double height15 = screenHeight / 52.06;
  static double height20 = screenHeight / 39.05;
  static double height30 = screenHeight / 26.03;
  static double height45 = screenHeight / 17.35;

  static double width10 = screenHeight / 78.1;
  static double width15 = screenHeight / 52.06;
  static double width20 = screenHeight / 39.05;
  static double width30 = screenHeight / 26.03;

  //font size
  static double font16 = screenHeight / 48.81;
  static double font20 = screenHeight / 39.05;
  static double font26 = screenHeight / 30.03;

  static double radius15 = screenHeight / 52.06;
  static double radius20 = screenHeight / 39.05;
  static double radius30 = screenHeight / 26.03;

  //icon Size
  static double iconSize24 = screenHeight / 32.54;
  static double iconSize16 = screenHeight / 48.81;
  static double iconSize13 = screenHeight / 60.07;

  //list view size
  static double listViewImgSize = screenWidth / 3.01;
  static double listViewTextSize = screenWidth / 3.61;

  //popular food
  static double popularFoodImgSize = screenHeight / 2.23;

  //bottom height
  static double bottomHeightBar = screenHeight / 6.5;
  // splash screen dimensions
  static double splashImg = screenHeight / 3.38;
}
