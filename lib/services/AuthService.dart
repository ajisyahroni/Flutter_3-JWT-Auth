import 'dart:convert';
import 'package:TweetMe/apis/ApiService.dart';
import 'package:TweetMe/services/StorageService.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    final loginPath = ApiService().setMainPath("/login");
    final response = await ApiService()
        .client
        .post(loginPath, body: {"email": email, "password": password});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // get token data to json
      final credential = jsonData['credential'];
      final token = credential['token'];

      await StorageService().writeToken(token.toString());
      return jsonData['success'];
    }
  }
}
