import 'package:flutter/material.dart';
import 'package:sign_in_by_apple_id/screens/password_screen/widgets/input_password.dart';
import 'package:sign_in_by_apple_id/widgets/image_background.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: const SafeArea(
        child: Stack(
          children: [
            ImageBackground(),
            Align(
              alignment: Alignment.bottomCenter,
              child: InpitPassword(),
            ),
          ],
        ),
      ),
    );
  }
}
