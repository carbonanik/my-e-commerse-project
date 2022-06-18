import 'package:get/get.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/utils/constants.dart';

import '../api/http_service.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  final HttpService httpService;


  RecommendedProductRepo({required this.apiClient,
    required this.httpService
  });

  // Future<Response> getRecommendedProduct() async {
  //   return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  // }

  Future<Response> getRecommendedProduct() async {
    var body = await httpService.getData(AppConstants.BASE_URL + AppConstants.RECOMMENDED_PRODUCT_URI);
    Response response = Response(
        body: body,
        statusCode: 200
    );
    return response;
  }
}