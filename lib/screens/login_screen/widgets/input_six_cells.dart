import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_by_apple_id/domain/auth_state.dart';

class InpitSixCells extends StatelessWidget {
  const InpitSixCells({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthState>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          children: [
            SizedBox(width: 20),
            RotationTransition(
              turns: AlwaysStoppedAnimation(225 / 360),
              child: Icon(
                Icons.sim_card,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'SIM ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PinCodeTextField(
                enabled: !context.watch<AuthState>().isLoading,
                appContext: context,
                length: 6,
                onChanged: state.setCode,
                autoFocus: true,
                showCursor: true,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                hintCharacter: '0',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                ),
                textStyle: const TextStyle(
                  color: Colors.black,
                ),
                inputFormatters: AuthState.inputFormattersByNumbers,
                errorTextMargin: EdgeInsets.zero,
                errorTextSpace: 2,
                enableActiveFill: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  fieldOuterPadding: EdgeInsets.zero,
                  borderWidth: 1.5,
                  fieldHeight: 60,
                  fieldWidth: (screenWidth - 80) / 6,
                  inactiveColor: Colors.transparent,
                  activeColor: Colors.transparent,
                  selectedColor: Colors.transparent,
                  activeFillColor: Colors.grey[300],
                  selectedFillColor: Colors.grey[300],
                  inactiveFillColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: screenWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: context.watch<AuthState>().hasError ? 1 : 0,
                child: const Text(
                  'Form validation Error',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: context.watch<AuthState>().isLoading ? 1 : 0,
                child: const CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Find out password *123#',
              style: TextStyle(color: Colors.yellow[600], fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
