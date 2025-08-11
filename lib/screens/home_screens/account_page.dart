import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_account.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/tag_account.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _showLogoutConfirmation(BuildContext context) async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: white,
          title: Text(
            'Xác nhận đăng xuất',
            style: TextStyle(
              color: textColor1,
              fontFamily: "LD",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Bạn có chắc muốn đăng xuất không?',
            style: TextStyle(
              color: textColor3,
              fontFamily: "LD",
              fontSize: 15,
              //fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'Hủy',
                    style: TextStyle(
                      color: textColor1,
                      fontFamily: "LD",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Đăng xuất',
                    style: TextStyle(
                      color: textColor1,
                      fontFamily: "LD",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

      if (shouldLogout == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        Navigator.pushReplacementNamed(context, 'loginPage');
      }
    }

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
                  name: "Quản lý đơn hàng",
                  ontap: "listOrderPage",
                ),
                TagAccount(
                  imgPath: "assets/icons/system_icon/24px/Right.png",
                  name: "Đăng xuất",
                  ontap: () => _showLogoutConfirmation(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
