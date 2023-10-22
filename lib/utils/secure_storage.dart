import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyNewUser = 'newUser';
  static const _keyOtp = 'otp';

  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future deleteSecureStorage() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyNewUser);
  }

  static Future setNewUser(String newUser) async {
    await _storage.write(key: _keyNewUser, value: newUser);
  }

  static Future<String?> fetchNewUser() async {
    return await _storage.read(key: _keyNewUser);
  }

  static Future setOtp(String otp) async {
    await _storage.write(key: _keyOtp, value: otp);
  }

  static Future<String?> fetchOtp() async {
    return await _storage.read(key: _keyOtp);
  }

  static Future deleteOtp() async {
    await _storage.delete(key: _keyOtp);
  }
}
