import 'package:flutter/material.dart';
import 'package:linsta_app/screens/login_screens/widgets/app_bar_login.dart';
import 'package:linsta_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:linsta_app/screens/login_screens/widgets/text_input.dart';
import 'package:linsta_app/ui_values.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: getHeight(context),
        color: white,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80),
              Center(
                child: Image.asset("assets/imgs/logo_blue.png", height: 72),
              ),
              SizedBox(height: 20),
              Text(
                "Chào mừng đến với Linsta !",
                style: TextStyle(
                  fontFamily: "LD",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: textColor1,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Đăng nhập để tiếp tục",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 15,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 30),
              TextInput(
                controller: emailController,
                isObscureText: false,
                hintText: "Địa chỉ Email",
                iconPath: 'assets/icons/system_icon/24px/Message.png',
              ),
              SizedBox(height: 20),
              TextInput(
                controller: passwordController,
                isObscureText: true,
                hintText: "Mật khẩu",
                iconPath: 'assets/icons/system_icon/24px/Password.png',
              ),
              SizedBox(height: 20),
              ButtonInput(
                text: "Đăng nhập",
                emailController: emailController,
                passwordController: passwordController,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "confirmEmailPage");
                },
                child: Text(
                  "Quên mật khẩu ?",
                  style: TextStyle(
                    color: mainColor,
                    fontFamily: "LD",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản ?",
                    style: TextStyle(
                      color: textColor2,
                      fontFamily: "LD",
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "registerPage");
                    },
                    child: Text(
                      "Đăng kí",
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: "LD",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
