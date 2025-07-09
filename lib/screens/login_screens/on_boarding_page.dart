import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, "loginPage");
    });
  }

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
