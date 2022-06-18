import 'dart:convert';
import 'dart:io';

class HttpService {

  // var url = 'https://mvs.bslmeiyu.com/api/v1/products/popular';

  Future<dynamic> getData(String url) async {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    HttpClientRequest request = await client
        .getUrl(Uri.parse(url));
    request.headers.set('Content-Type', 'application/json');

    HttpClientResponse result = await request.close();

    if (result.statusCode == 200) {
      return jsonDecode(await result.transform(utf8.decoder).join());
    } else {
      return null;
    }
  }
}
