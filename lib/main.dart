import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/controller/popular_product_controller.dart';
import 'package:my_e_com/routes/route_helper.dart';
import 'package:my_e_com/screen/home/food_page_body.dart';
import 'package:my_e_com/screen/home/main_food_page.dart';
import 'controller/recommended_product_controller.dart';
import 'helpers/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: RouteHelper.initial,
      getPages: RouteHelper.routes,
    );
  }
}
