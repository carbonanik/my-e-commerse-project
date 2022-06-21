import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/base/no_data_page.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/controller/cart_controller.dart';
import 'package:my_e_com/controller/popular_product_controller.dart';
import 'package:my_e_com/controller/recommended_product_controller.dart';
import 'package:my_e_com/model/cart_model.dart';
import 'package:my_e_com/routes/route_helper.dart';
import 'package:my_e_com/utils/dimensions.dart';
import 'package:my_e_com/widgets/app_icon.dart';
import 'package:my_e_com/widgets/big_text.dart';
import 'package:my_e_com/widgets/small_text.dart';

import '../../utils/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // top bar / top button row
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // back button
                  AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  // home button
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              )),
          // cart item list
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length > 0 ? Positioned(
                top: Dimensions.height20 * 5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (controller) {
                        var cartList = controller.getItems;
                        // cart items
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (_, index) {
                              var cartItem = cartList[index];
                              return _listItem(cartItem, controller);
                            });
                      },
                    ),
                  ),
                )) : NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (controller) {
          return Container(
            height: Dimensions.bottomBarHeight,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2)),
                color: AppColors.buttonBackgroundColor),
            child: controller.getItems.isNotEmpty ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// total price
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: "\$ ${controller.totalAmount}"),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                    ],
                  ),
                ),
                /// check out button
                GestureDetector(
                  onTap: () {
                    // popularProduct.addItem(product);
                    controller.addToHistory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: BigText(
                      text: 'Check Out',
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ) : Container(),
          );
        },
      ),
    );
  }

  Widget _listItem(CartModel cartItem, CartController controller) {
    return Container(
      height: Dimensions.height20 * 5,
      width: double.maxFinite,
      child: Row(
        children: [
          // tappable item image
          GestureDetector(
            onTap: () {
              _findProductAndNavigate(cartItem);
            },
            child: Container(
              width: Dimensions.height20 * 5,
              height: Dimensions.height20 * 5,
              margin: EdgeInsets.only(bottom: Dimensions.height10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "${AppConstants.IMAGE_BASE_URL}${cartItem.img}"
                      ))),
            ),
          ),
          SizedBox(
            width: Dimensions.width10,
          ),
          // item information
          Expanded(
              child: Container(
            height: Dimensions.height20 * 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // item name
                BigText(
                  text: cartItem.name!,
                  color: Colors.black54,
                ),
                SmallText(text: "Spicy"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // item price
                    BigText(
                      text: "\$ ${cartItem.price}",
                      color: Colors.redAccent,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height10,
                          bottom: Dimensions.height10,
                          left: Dimensions.width10,
                          right: Dimensions.width10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          // decrease item button
                          GestureDetector(
                            onTap: () {
                              controller.setItemQuantity(
                                  cartItem.product!,
                                  controller.getQuantity(
                                      cartItem.product!.id!
                                  ) - 1);
                            },
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.signColor,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          // item quantity
                          BigText(text: "${cartItem.quantity}"),
                          SizedBox(
                            width: Dimensions.width10 / 2,
                          ),
                          // increase item button
                          GestureDetector(
                            onTap: () {
                              controller.setItemQuantity(
                                  cartItem.product!,
                                  controller.getQuantity(
                                      cartItem.product!.id!
                                  ) + 1);
                            },
                            child: const Icon(
                              Icons.add,
                              color: AppColors.signColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  void _findProductAndNavigate(CartModel cartItem) {
    // find item in popular list by id
    int? popularProductId = Get.find<PopularProductController>()
        .popularProductList
        .firstWhereOrNull((element) {
      return element.id == cartItem.id!;
    })?.id;

    if (popularProductId != null) {
      Get.toNamed(RouteHelper.getPopularFood(popularProductId));
    } else {
      // find item in recommended list by id
      int? recommendedProductId = Get.find<RecommendedProductController>()
          .recommendedProductList
          .firstWhereOrNull((element) {
        return element.id == cartItem.id!;
      })?.id;
      if (recommendedProductId != null) {
        Get.toNamed(RouteHelper.getRecommendedFood(recommendedProductId));
      }
    }
  }
}
