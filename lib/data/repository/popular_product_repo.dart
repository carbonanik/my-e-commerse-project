import 'package:get/get.dart';
import 'package:my_e_com/data/api/api_client.dart';
import 'package:my_e_com/utils/constants.dart';

class PopularProductRepo extends GetxService{
  final ApiClient apiClient;

  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProduct() async {
    return apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}