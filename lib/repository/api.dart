import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api {
  static String url = 'https://mlc.candodream.com/test';
  static Dio dio = Dio();

  static Future<bool> verifyCode(String simid, String udid) async {
    final Map<String, dynamic> body = {
      'simid': simid,
      'udid': udid,
    };
    final response = await _post(url, body: body);
    final result = response.containsKey('passwd');
    return result;
  }

  static Future<Map<String, dynamic>> _post(String url,
      {Map<String, dynamic> body = const {}}) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};

    try {
      Response response = await dio.post(url,
          data: body,
          options: Options(
            headers: headers,
          ));
      if (response.statusCode == 200 && response.data != null) {
        return json.decode(response.data);
      } else {
        throw WrongDataException(response.statusCode.toString());
      }
    } on DioException catch (dioError) {
      if (dioError.type == DioExceptionType.connectionError) {
        debugPrint('Connection Error');
      } else if (dioError.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout');
      } else if (dioError.type == DioExceptionType.badResponse) {
        debugPrint('Server Error: ${dioError.response?.statusCode}');
      } else if (dioError.type == DioExceptionType.unknown) {
        debugPrint('Unexpected Error: ${dioError.message}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return {};
  }
}

class WrongDataException implements Exception {
  String cause;
  WrongDataException(this.cause);
}
