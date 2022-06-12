import 'package:get/get.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/controller/popular_product_controller.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/data/repository/cart_repo.dart';
import 'package:my_e_com/data/repository/popular_product_repo.dart';
import 'package:my_e_com/utils/constants.dart';

import '../controller/recommended_product_controller.dart';
import '../data/repository/recommended_product_rapo.dart';

Future<void> init() async {
  // api clients
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  // repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());


  // controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));

}
