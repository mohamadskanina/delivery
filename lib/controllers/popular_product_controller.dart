import 'dart:ui';

import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/models/products_models.dart';
import 'package:get/get.dart';
import '../data/repository/popular_product_repo.dart';
import '../models/cart_model.dart';

class PopulerProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopulerProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      //  print("number of item "+_quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      //  print("number of item "+_quantity.toString());
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("عدد الطلبات", "خطأ في إدخال عدد الطلبات",
          backgroundColor: Color.fromARGB(225, 103, 171, 151),
          colorText: Color(0xfff6f6f6));
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }
    // else if ((_inCartItems+quantity) > 20) {
    //   Get.snackbar("عدد الطلبات", "الكمية المطلوبة غير متاحة",
    //       backgroundColor:Color.fromARGB(225, 103, 171, 151),
    //       colorText: Color(0xfff6f6f6)
    //   );
    //   return 20;
    // }
    // else
    return quantity;
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if exist
    //get from storage _inCartItems
    print("exist or not " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("the quantity is " + _inCartItems.toString());
  }

  void addItem(
    ProductModel product,
  ) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);

    _cart.items.forEach((key, value) {
      print("the id is " +
          value.id.toString() +
          " the quantity " +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
