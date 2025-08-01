import 'package:flutter/material.dart';
import 'package:linsta_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:linsta_app/screens/login_screens/widgets/button_input_register.dart';
import 'package:linsta_app/screens/login_screens/widgets/text_input.dart';
import 'package:linsta_app/ui_values.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        height: getHeight(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
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
                "Tạo tài khoản mới",
                style: TextStyle(
                  fontFamily: "LD",
                  fontSize: 15,
                  color: textColor2,
                ),
              ),
              SizedBox(height: 30),
              TextInput(
                controller: nameController,
                isObscureText: false,
                hintText: "Họ và tên",
                iconPath: 'assets/icons/system_icon/24px/User.png',
              ),
              SizedBox(height: 20),
              TextInput(
                controller: phoneController,
                isObscureText: false,
                hintText: "Số điện thoại",
                iconPath: 'assets/icons/system_icon/24px/Phone.png',
              ),
              SizedBox(height: 20),
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
              TextInput(
                controller: addressController,
                isObscureText: false,
                hintText: "Địa chỉ",
                iconPath: 'assets/icons/system_icon/24px/Location.png',
              ),
              SizedBox(height: 20),
              ButtonInputRegister(
                text: "Đăng kí",
                emailController: emailController,
                passwordController: passwordController,
                addressController: addressController,
                nameController: nameController,
                phoneController: phoneController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn đã có tài khoản ?",
                    style: TextStyle(
                      color: textColor2,
                      fontFamily: "LD",
                      fontSize: 16,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Đăng nhập",
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
