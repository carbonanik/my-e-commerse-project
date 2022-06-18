import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/data/repository/cart_repo.dart';
import 'package:my_e_com/model/popular_products.dart';

import '../colors.dart';
import '../model/cart_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});

  /// current item in cart list
  final Map<int, CartModel> _cartItems = {};
  Map<int, CartModel> get cartItems => _cartItems;

  /// cart list retrieved from shared preference
  // List<CartModel> storageItem = [];

  /// add update or remove product from current cart list
  void setItemQuantity(ProductModel product, int quantity) {

    if (existInCart(product)) {
      _updateItemQuantity(product, quantity);

    } else {
      if (quantity > 0) {
        _addItemToCart(product, quantity);
      } else {
        Get.snackbar("Cart", "You should at least add an item",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    addToCartList();
  }

  void _addItemToCart(ProductModel product, int quantity) {
    _cartItems.putIfAbsent(product.id!, () {
      return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product);
    });

  }

  void _updateItemQuantity(ProductModel product, int quantity) {
    _cartItems.update(product.id!, (value) {
      return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: quantity,
          isExist: value.isExist,
          time: DateTime.now().toString(),
          product: product);
    });

    if (quantity <= 0) {
      _cartItems.remove(product.id);
    }
  }

  /// check if product exist in cart
  bool existInCart(ProductModel product) {
    return _cartItems.containsKey(product.id);
  }

  /// quantity of a product in cart list
  int getQuantity(int productId) {
    var quantity = 0;
    if (_cartItems.containsKey(productId)) {
      _cartItems.forEach((key, value) {
        if (key == productId) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  /// total product count in cart list
  int get totalItems {
    var totalQuantity = 0;
    _cartItems.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  /// total item in cart list
  List<CartModel> get getItems {
    return _cartItems.values.toList();
  }

  /// total price of total product in cart list
  int get totalAmount {
    var total = 0;
    _cartItems.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  /// get saved cart list from shared preference
  void getCartData() {

    var storageItems = cartRepo.getCartList();
    for (int i = 0; i < storageItems.length; i++) {
      _cartItems.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  /// set retrieved cart items to cart list
  // set setCart(List<CartModel> items) {
  //   storageItem = items;
  //
  //   for (int i = 0; i < storageItem.length; i++) {
  //     _cartItems.putIfAbsent(storageItem[i].product!.id!, () => storageItem[i]);
  //   }
  // }

  /// add cart list to history and clear the list when check out
  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  /// clear the cart list
  void clear(){
    _cartItems.clear();
    update();
  }

  /// get saved cart history list
  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }

  /// categorize history cart list by order time.
  Map<String, List<CartModel>> getCartHistoryListPerOrder(){
    List<CartModel> cartHistoryList = getCartHistoryList().reversed.toList();

    print(cartHistoryList.map((e) => e.name));

    Map<String, List<CartModel>> cartItemPerOrder = {};

    for (CartModel item in cartHistoryList) {

      if (cartItemPerOrder.containsKey(item.time)) {
        cartItemPerOrder.update(item.time!, (value) {
          var timeList = value;
          timeList.add(item);
          return timeList;
        });
      } else {
        cartItemPerOrder.putIfAbsent(item.time!, () => [item]);
      }
    }

    return cartItemPerOrder;
  }

  /// for replacing current cart item
  set replaceCartItems(Map<int, CartModel> items){
    _cartItems.clear();
    _cartItems.addAll(items);
    addToCartList();
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }
}
