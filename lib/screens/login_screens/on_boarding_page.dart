import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: Center(
        child: Image.asset('assets/imgs/logo_white.png', height: 90),
      ),
    );
  }
}
