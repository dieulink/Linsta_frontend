import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 110),
            Center(child: Image.asset("assets/imgs/logo_blue.png", height: 72)),
            Text(
              "Chào mừng bạn đến với Linsta",
              style: TextStyle(
                fontFamily: "LD",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor1,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Đăng nhập để tiếp tục",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 15,
                color: textColor2,
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
