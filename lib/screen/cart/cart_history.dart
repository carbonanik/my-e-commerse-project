import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_e_com/base/no_data_page.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/routes/route_helper.dart';
import 'package:my_e_com/utils/dimensions.dart';
import 'package:my_e_com/widgets/app_icon.dart';
import 'package:my_e_com/widgets/big_text.dart';

import '../../controller/popular_product_controller.dart';
import '../../controller/recommended_product_controller.dart';
import '../../model/cart_model.dart';
import '../../utils/constants.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, List<CartModel>> historyPerOrder = Get.find<CartController>().getCartHistoryListPerOrder();

    return Scaffold(
      body: Column(
        children: [
          /// top app bar
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding:
                EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width20, right: Dimensions.width30, bottom: Dimensions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                  size: Dimensions.font26,
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                )
              ],
            ),
          ),

          /// history list
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < historyPerOrder.length; i++)
                                Container(
                                  // height: 120,
                                  margin: EdgeInsets.only(bottom: Dimensions.height20),
                                  /// order item in list
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // BigText(
                                      //     text:
                                      //         cartHistoryListPerOrder.keys.toList()[i]),
                                      /// order date
                                      (() {
                                        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(historyPerOrder.keys.toList()[i]);
                                        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                        var outputDate = outputFormat.format(parseDate);
                                        return BigText(text: outputDate);
                                      }()),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            /// horizontal item images list for per order
                                            children: List.generate(historyPerOrder.values.toList()[i].length, (index) {
                                              return index <= 2
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        _findProductAndNavigate(historyPerOrder.values.toList()[i][index]);
                                                      },

                                                      /// item image of per order
                                                      child: Container(
                                                        height: Dimensions.height20 * 4,
                                                        width: Dimensions.width20 * 4,
                                                        margin: EdgeInsets.only(right: Dimensions.width10),
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                                            image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    "${AppConstants.IMAGE_BASE_URL}${historyPerOrder.values.toList()[i][index].img}"))),
                                                      ),
                                                    )
                                                  : Container();
                                            }),
                                          ),

                                          Container(
                                            // height: 100,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: "${historyPerOrder.values.toList()[i].length} Items",
                                                  color: AppColors.titleColor,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.find<CartController>().replaceCartItems = {
                                                      for (var e in historyPerOrder.values.toList()[i]) e.id!: e
                                                    };
                                                    Get.toNamed(RouteHelper.getCartPage());
                                                  },

                                                  /// button for adding more item to odored. (one more button)
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: Dimensions.width10 / 2, vertical: Dimensions.height10 / 4),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                                      border: Border.all(width: 1, color: AppColors.mainColor),
                                                    ),
                                                    child: SmallText(
                                                      text: "one more",
                                                      color: AppColors.mainColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          )),
                    ),
                  )

                /// Cart history empty
                : Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(child: NoDataPage(text: "You didn't buy anything so far")));
          })
        ],
      ),
    );
  }

  void _findProductAndNavigate(CartModel cartItem) {
    /// find item in popular list by id
    int? popularProductId = Get.find<PopularProductController>().popularProductList.firstWhereOrNull((element) {
      return element.id == cartItem.id!;
    })?.id;

    if (popularProductId != null) {
      Get.toNamed(RouteHelper.getPopularFood(popularProductId));
    } else {
      /// find item in recommended list by id
      int? recommendedProductId = Get.find<RecommendedProductController>().recommendedProductList.firstWhereOrNull((element) {
        return element.id == cartItem.id!;
      })?.id;
      if (recommendedProductId != null) {
        Get.toNamed(RouteHelper.getRecommendedFood(recommendedProductId));
      }
    }
  }
}
