import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {
  const ImageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          width: screenWidth + 200,
          height: screenWidth + 200,
          top: -140,
          left: -100,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff444444),
            ),
          ),
        ),
        Positioned(
          width: screenWidth + 100,
          height: screenWidth + 100,
          top: -90,
          left: -50,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff5f5f5f),
            ),
          ),
        ),
        Positioned(
          width: screenWidth,
          height: screenWidth,
          top: -40,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff797979),
            ),
          ),
        ),
        const Align(
          alignment: Alignment(0, -1),
          child: Icon(
            Icons.person,
            size: 300,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
