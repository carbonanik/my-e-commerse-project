import 'package:get/get.dart';
import 'package:my_e_com/utils/constants.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}){
    baseUrl = appBaseUrl;
    token = AppConstants.TOKEN;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-Type': 'Application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async{
    try{
      Response res = await get(uri);
      return res;
    } catch(e){
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}