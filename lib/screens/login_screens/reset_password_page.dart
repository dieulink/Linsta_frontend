import 'package:flutter/material.dart';
import 'package:linsta_app/screens/login_screens/widgets/button_input.dart';
import 'package:linsta_app/screens/login_screens/widgets/text_input.dart';
import 'package:linsta_app/ui_values.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 80),
            Center(child: Image.asset("assets/imgs/logo_blue.png", height: 72)),
            SizedBox(height: 20),
            Text(
              "Nhập mã OTP ",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 15,
                color: textColor2,
              ),
            ),
            SizedBox(height: 30),
            text_input(
              isObscureText: false,
              hintText: "Mã OTP",
              iconPath: 'assets/icons/system_icon/24px/Password.png',
            ),
            SizedBox(height: 20),
            // SizedBox(height: 1, child: Container(color: textColor2)),
            SizedBox(height: 20),
            Text(
              "Đặt lại mật khẩu",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 15,
                color: textColor2,
              ),
            ),
            SizedBox(height: 20),
            text_input(
              isObscureText: true,
              hintText: "Mật khẩu",
              iconPath: 'assets/icons/system_icon/24px/Password.png',
            ),
            SizedBox(height: 20),
            text_input(
              isObscureText: false,
              hintText: "Xác nhận mật khẩu",
              iconPath: 'assets/icons/system_icon/24px/Password.png',
            ),
            SizedBox(height: 30),
            button_input(text: "Đổi mật khẩu"),
          ],
        ),
      ),
    );
  }
}
