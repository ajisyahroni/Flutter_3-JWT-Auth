import 'dart:io';
import 'package:http/http.dart' show Client;

class ApiService {
  static const String baseUrl = "https://alfabank-blog.herokuapp.com/api/v1";
  Client client = Client();

  String setMainPath(String mainPath) {
    return baseUrl + mainPath;
  }

  getWithHeader(String url, String bearerToken) {
    return client.get("url",
        headers: {HttpHeaders.authorizationHeader: "Bearer $bearerToken"});
  }
}
