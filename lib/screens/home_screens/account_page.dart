import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/widgets/app_bar_account.dart';
import 'package:linsta_app/screens/account_screens/widgets/tag_account.dart';
import 'package:linsta_app/ui_values.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      //appBar: AppBarAccount(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "Quản lý tài khoản",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            margin: EdgeInsets.only(top: 40),
            color: borderColor,
          ),
          Container(
            //padding: EdgeInsets.all(10),
            color: white,

            child: Column(
              children: [
                TagAccount(
                  imgPath: "assets/icons/system_icon/24px/User.png",
                  name: "Thông tin cá nhân",
                  ontap: "profilePage",
                ),
                TagAccount(
                  imgPath: "assets/icons/system_icon/24px/Location.png",
                  name: "Thông tin địa chỉ",
                  ontap: "addressPage",
                ),
                TagAccount(
                  imgPath: "assets/icons/system_icon/24px/bag.png",
                  name: "Đơn hàng",
                  ontap: "orderPage",
                ),
                TagAccount(
                  imgPath: "assets/icons/system_icon/24px/Right.png",
                  name: "Đăng xuất",
                  ontap: "",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
