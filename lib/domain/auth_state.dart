import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sign_in_by_apple_id/repository/api.dart';
import 'package:sign_in_by_apple_id/router/router_config.dart';
import 'package:uuid/uuid.dart';

class AuthState extends ChangeNotifier {
  bool hasError = false;
  bool isLoading = false;
  String? simid;

  void setCode(String? text) async {
    simid = text;
    if (simid != null && simid!.length == 6) {
      isLoading = true;
      hasError = false;
      notifyListeners();
      try {
        final codeIsCorrect = await verifyCode();
        if (codeIsCorrect) {
          Routes.router.go(Routes.password);
        } else {
          hasError = true;
        }
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<bool> verifyCode() async {
    final udid = const Uuid().v4();
    final codeIsCorrect = await Api.verifyCode(simid!, udid);
    return codeIsCorrect;
  }

  static List<TextInputFormatter> inputFormattersByNumbers = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+')),
  ];
}
