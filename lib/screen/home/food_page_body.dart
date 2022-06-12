import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_e_com/colors.dart';
import 'package:my_e_com/controller/popular_product_controller.dart';
import 'package:my_e_com/controller/recommended_product_controller.dart';
import 'package:my_e_com/model/popular_products.dart';
import 'package:my_e_com/routes/route_helper.dart';
import 'package:my_e_com/widgets/app_column.dart';
import 'package:my_e_com/widgets/big_text.dart';
import 'package:my_e_com/widgets/icon_and_text.dart';
import 'package:my_e_com/widgets/small_text.dart';

import '../../utils/dimensions.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.9);
  var _currentPageValue = 0.00;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // popular food slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              //slider
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPopularPageItem(position,
                          popularProducts.popularProductList[position]);
                    },
                    controller: pageController,
                  ),
                )
              // data loading indicator
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        // slider dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        // space
        SizedBox(
          height: Dimensions.height30,
        ),
        // recommended text
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.width30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'Food pairing',
                ),
              )
            ],
          ),
        ),
        // recommended food and image list
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return _buildRecommendedListItem(index,
                        recommendedProduct.recommendedProductList[index]);
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
      ],
    );
  }

  Widget _buildPopularPageItem(
    int index,
    ProductModel popularProduct,
  ) {
    Matrix4 matrix = _getPageTransformation(index);

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? const Color(0xff89dad0)
                      : const Color(0xffffd28d),
                  image: const DecorationImage(
                      image: AssetImage(//todo network image alter backend build
                          'assets/images/iso-republic-fruit-plate.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xffe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                          offset: Offset(-5, 0)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 1.0,
                          offset: Offset(5, 0))
                    ]),
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.width15,
                      right: Dimensions.width15),
                  child: AppColumn(
                    text: popularProduct.name!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedListItem(
    int index,
    ProductModel product,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getRecommendedFood(index));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: Dimensions.height10),
        child: Row(
          children: [
            // image section
            Container(
              height: Dimensions.listViewImgSize,
              width: Dimensions.listViewImgSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white38,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(// todo network image
                          'assets/images/isorepublic-prawns-1.jpg'))),
            ),
            // text container
            Expanded(
                child: Container(
              height: Dimensions.listViewTextConSize,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: product.name!),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    SmallText(text: 'With Chaines Characteristic'),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: 'Normal',
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.location_on,
                            text: '1.7km',
                            iconColor: AppColors.iconColor2),
                        IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: '32min',
                            iconColor: AppColors.iconColor1)
                      ],
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Matrix4 _getPageTransformation(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale = 1 + (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    return matrix;
  }
}
