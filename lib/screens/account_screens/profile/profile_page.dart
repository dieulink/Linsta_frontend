import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/widgets/tag_profile.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "";
  String email = "";
  String phone = "";

  @override
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Không có';
      email = prefs.getString('email') ?? 'Không có';
      phone = prefs.getString('phone') ?? 'Không có';
    });
  }

  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarProfile(name: "Thông tin cá nhân"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              height: 1,
              margin: EdgeInsets.only(top: 10, bottom: 20),
              color: borderColor,
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(100),
                child: Image.asset("assets/imgs/avt.png", height: 100),
              ),
            ),
            TagProfile(
              name: "Tên người dùng",
              value: name,
              nextPage: "",
              iconPath: "assets/icons/system_icon/24px/Username.png",
            ),
            TagProfile(
              name: "Email",
              value: email,
              nextPage: "",
              iconPath: "assets/icons/system_icon/24px/Message.png",
            ),
            TagProfile(
              name: "Số điện thoại",
              value: phone,
              nextPage: "",
              iconPath: "assets/icons/system_icon/24px/Phone.png",
            ),
          ],
        ),
      ),
    );
  }
}
