import 'package:get/get.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/data/repository/popular_product_repo.dart';

import '../model/cart_model.dart';
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

  int getQuantity(int productId){
    if(quantity > 0){
      return _quantity;
    } else {
      return _cart.getQuantity(productId);
    }
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProduct();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("data getting error");
    }
  }

  void increaseQuantity(){
    _quantity += 1;
    if(_quantity > 20) _quantity = 20;
    update();
  }

  void decreaseQuantity(){
    _quantity -= 1;
    if(_quantity < 0) _quantity = 0;
    update();
  }

  void initProduct(int productId, CartController cart) {
    print('init product');
    _quantity = 0;
    _cart = cart;
    _quantity = _cart.getQuantity(productId);
  }

  void resetQuantity(){
    _quantity = 0;
  }

  void addItem(ProductModel product) {
    _cart.setItemQuantity(product, _quantity);
    update();
  }

  void updateData(){
    print("update data");
    update();
  }

  int get totalItem {
    return _cart.totalItems;
  }

  List<CartModel> get getItem {
    return _cart.getItems;
  }
}
