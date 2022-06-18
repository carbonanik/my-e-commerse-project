import 'dart:convert';

import 'package:my_e_com/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  /// current cart list // before checkout
  List<String> cart=[];
  /// old checkout cart item // history
  List<String> cartHistory=[];

  /// store cart list to shared preference
  void addToCartList(List<CartModel> cartList){
    String time = DateTime.now().toString();
    cart = [];
    for (var element in cartList) {
      var e = element;
      e.time = time;
      cart.add(jsonEncode(e));
    }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  }

  /// get cart list from shared preference
  List<CartModel> getCartList(){
    //also get previous cart history

    cartHistory = _getCartHistoryListJson();

    List<String> carts = [];
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }

    List<CartModel> cartList = [];
    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartList;
  }

  /// store current cart list to history cart list
  /// clear current cart list
  void addToCartHistoryList(){
    for(int i = 0; i< cart.length; i++){
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  }

  /// clear current cart list
  void removeCart(){
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  /// get all item from history cart list
  List<CartModel> getCartHistoryList(){
    List<String> listJson = _getCartHistoryListJson();

    List<CartModel> cartHistory =[];
    for (var element in listJson) {
      cartHistory.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartHistory;
  }

  /// get all item from history cart list
  List<String> _getCartHistoryListJson(){
    List<String> listJson = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      listJson = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    return listJson;
  }

}