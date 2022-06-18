import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/routes/route_helper.dart';
import 'package:my_e_com/utils/dimensions.dart';

import '../../controller/cart_controller.dart';
import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
            scale: animation,
            child: Center(child: Image.asset('assets/images/isorepublic-prawns-1.jpg', width: Dimensions.splashImg,)))
      ],
    ),);
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(Duration(milliseconds: 100), () {
      Get.toNamed(RouteHelper.getInitial());
    });
  }

  _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>().getCartData();
  }
}
