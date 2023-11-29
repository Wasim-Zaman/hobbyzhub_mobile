import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyUserId = 'userId';

  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future setUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  static Future<String?> fetchUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  static Future deleteAll() async {
    await _storage.deleteAll();
  }
}
