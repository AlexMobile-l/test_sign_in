import 'package:flutter/material.dart';
import 'package:sign_in_by_apple_id/domain/service/auth_service.dart';
import 'package:sign_in_by_apple_id/theme/assets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Auth by Apple ID'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () async {
                    final result = await AuthService().authorizeWithApple();
                    final udid = await AuthService().getPersistentUUID();
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(result ? 'Успешно' : 'Ошибка'),
                        content: Text(
                            result ? 'UDID: $udid' : 'Авторизация не удалась'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'))
                        ],
                      ),
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.iconApple,
                        width: 24,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        'Sign in with Apple',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )),
            ),
          ),
        ));
  }
}
