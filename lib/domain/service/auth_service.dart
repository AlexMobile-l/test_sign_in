import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uuid/uuid.dart';
import 'rsa_key_service.dart';

class AuthService {
  final RSAKeyService rsaKeyService = RSAKeyService();
  final dio = Dio();
  final user = 'appleUser';
  final email = 'email@gmail.com';

  Future<bool> authorizeWithApple() async {
    try {
      // final credential = await SignInWithApple.getAppleIDCredential(
      //   scopes: [
      //     AppleIDAuthorizationScopes.email,
      //     AppleIDAuthorizationScopes.fullName
      //   ],
      // );
      final udid = await getPersistentUUID();
      final rnd = const Uuid().v4();
      final signatureData = '$udid$rnd$user';
      final signature = rsaKeyService.sign(signatureData).toString();

      await sendPublicKey(udid, rnd, signature);

      final success = await sendAuthorizationData(udid, rnd, signature);
      return success;
    } catch (e) {
      print('Ошибка авторизации: $e');
      return false;
    }
  }

  Future<void> sendPublicKey(String udid, String rnd, String signature) async {
    final response = await dio.post('https://your-server/init', data: {
      'oper': 'init',
      'udid': udid,
      'rnd': rnd,
      'pmk': '', //rsaKeyService.getPublicKeyPem(),
      'signature': signature,
      'fcm_key': '1',
    });
    if (response.data['error_code'] != 1) {
      throw Exception(
          'Ошибка отправки ключа: ${response.data['error_status']}');
    }
  }

  Future<bool> sendAuthorizationData(
      String udid, String rnd, String signature) async {
    final response = await dio.post('https://your-server/login', data: {
      'oper': 'login_apple_id',
      'udid': udid,
      'email': email,
      'login': user,
      'rnd': rnd,
      'signature': signature,
    });
    if (response.data['error_code'] == 1) {
      print('Успешно: ${response.data['work_status']}');
      return true;
    } else {
      print('Ошибка: ${response.data['error_status']}');
      return false;
    }
  }

  Future<String> getPersistentUUID() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'device_uuid';

    String? uuid = prefs.getString(key);
    if (uuid == null) {
      uuid = const Uuid().v4();
      await prefs.setString(key, uuid);
    }

    return uuid;
  }
}
