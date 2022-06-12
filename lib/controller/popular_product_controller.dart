import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/data/repository/popular_product_repo.dart';

import '../model/popular_products.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList = [];

  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItem=0;
  int get inCartItem => _inCartItem + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProduct();
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
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if (quantity < 0) {
      Get.snackbar("Item Count", "You cant reduce more",
      backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 0;
    } else if (quantity > 20) {
      Get.snackbar("Item Count", "You cant increase more",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart){
    _quantity=0;
    _inCartItem=0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCard(product);
    if(exist){
      _inCartItem = _cart.getQuantity(product);
    }
  }

  void addItem(ProductModel product){
    if(_quantity > 0){
      _cart.addItem(product, _quantity);
      _quantity = 0;
    } else {
      Get.snackbar("Item Count", "You should at least add an item",
          backgroundColor: AppColors.mainColor, colorText: Colors.white);
    }
  }
}
