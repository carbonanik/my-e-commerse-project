import 'package:get/get.dart';
import 'package:my_e_com/data/repository/cart_repo.dart';
import 'package:my_e_com/model/popular_products.dart';

import '../model/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  void addItem(ProductModel product, int quantity) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity!+quantity,
            isExist: value.isExist,
            time: DateTime.now().toString());
      });
    } else {
      _items.putIfAbsent(product.id!, () {
        return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString());
      });
    }
  }

  bool existInCard(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }else {
      return false;
    }
  }

  int getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
}
