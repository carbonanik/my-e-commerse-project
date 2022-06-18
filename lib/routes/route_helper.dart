import 'package:get/get.dart';
import 'package:my_e_com/screen/cart/cart_page.dart';
import 'package:my_e_com/screen/food/popular_food_detail.dart';
import 'package:my_e_com/screen/food/recomended_food_detail.dart';
import 'package:my_e_com/screen/home/home_page.dart';
import 'package:my_e_com/screen/splash/splash_page.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getSplashPage() => splashPage;

  static String getInitial() => initial;

  static String getPopularFood(int productId) =>
      '$popularFood?productId=$productId';

  static String getRecommendedFood(int productId) =>
      '$recommendedFood?productId=$productId';

  static String getCartPage() => "$cartPage";

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(
        name: initial,
        page: () => HomePage(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: popularFood,
        page: () {
          var productId = Get.parameters["productId"];
          return PopularFoodDetail(productId: int.parse(productId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          var productId = Get.parameters["productId"];
          return RecommendedFoodDetail(productId: int.parse(productId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return CartPage();
        },
        transition: Transition.fadeIn)
  ];
}
