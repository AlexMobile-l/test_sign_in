import 'package:flutter/material.dart';
import 'package:sign_in_by_apple_id/screens/login_screen/widgets/input_six_cells.dart';
import 'package:sign_in_by_apple_id/widgets/image_background.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              child: InpitSixCells(),
            ),
          ],
        ),
      ),
    );
  }
}
