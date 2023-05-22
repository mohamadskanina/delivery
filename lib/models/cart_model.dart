import 'package:delivery/models/products_models.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    time = json['time'];
    isExist = json['isExist'];
    product = ProductModel.fromJson(json['product']);
  }
  Map<String, dynamic> toJson() {
    return {
      " id ": this.id,
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "quantity": this.quantity,
      "time": this.time,
      "isExist": this.isExist,
      "product": this.product!.tojson(),
    };
  }
}
