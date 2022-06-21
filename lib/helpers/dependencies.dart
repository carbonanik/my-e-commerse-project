import 'package:get/get.dart';
import 'package:my_e_com/controller/auth_controllde.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/controller/popular_product_controller.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/data/api/http_service.dart';
import 'package:my_e_com/data/repository/auth_repo.dart';
import 'package:my_e_com/data/repository/cart_repo.dart';
import 'package:my_e_com/data/repository/popular_product_repo.dart';
import 'package:my_e_com/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_rapo.dart';

Future<void> init() async {
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreference);

  // api clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => HttpService());


  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find(), httpService: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find(), httpService: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
}
