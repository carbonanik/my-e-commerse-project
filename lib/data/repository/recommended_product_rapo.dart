import 'package:get/get.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/utils/constants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProduct() async {
    return apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}