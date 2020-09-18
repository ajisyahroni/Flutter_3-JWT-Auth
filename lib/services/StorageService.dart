import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _Storage = FlutterSecureStorage();
  final _tokenInitial = "jwt_token";

  Future<void> writeToken(String value) async {
    await _Storage.write(key: _tokenInitial, value: value);
  }

  Future<String> readToken() async {
    return await _Storage.read(key: _tokenInitial);
  }
}
