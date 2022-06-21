import 'dart:io';

import 'package:get/get.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/data/api/http_service.dart';
import 'package:my_e_com/utils/constants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;
  final HttpService httpService;

  PopularProductRepo({
    required this.apiClient,
    required this.httpService
  });

  Future<Response> getPopularProduct() async {
    return apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }

  // Future<Response> getPopularProduct() async {
  //   var body = await httpService.getData(AppConstants.BASE_URL + AppConstants.POPULAR_PRODUCT_URI);
  //   Response response = Response(
  //     body: body,
  //     statusCode: 200
  //   );
  //   return response;
  // }
}