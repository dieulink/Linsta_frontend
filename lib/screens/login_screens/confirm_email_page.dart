import 'package:flutter/material.dart';
import 'package:linsta_app/screens/login_screens/widgets/button_input.dart';
import 'package:linsta_app/screens/login_screens/widgets/text_input.dart';
import 'package:linsta_app/ui_values.dart';

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 80),
              Center(
                child: Image.asset("assets/imgs/logo_blue.png", height: 72),
              ),
              SizedBox(height: 20),
              Text(
                "Xác nhận Email của bạn",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 15,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 50),
              text_input(
                isObscureText: false,
                hintText: "Địa chỉ Email",
                iconPath: 'assets/icons/system_icon/24px/Message.png',
              ),
              SizedBox(height: 20),
              button_input(text: "Xác nhận"),
            ],
          ),
        ),
      ),
    );
  }
}
