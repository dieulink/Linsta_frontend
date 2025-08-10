import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/tag_profile.dart';
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
              nextPage: "editNamePage",
              iconPath: "assets/icons/system_icon/24px/Username.png",
            ),
            TagProfile(
              name: "Email",
              value: email,
              nextPage: "",
              iconPath: "assets/icons/system_icon/24px/Message.png",
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5, left: 5),
              child: Text(
                textAlign: TextAlign.left,
                "*Không thể chỉnh sửa Email",
                style: TextStyle(
                  color: const Color.fromARGB(150, 104, 112, 136),
                  fontFamily: "LD",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TagProfile(
              name: "Số điện thoại",
              value: phone,
              nextPage: "",
              iconPath: "assets/icons/system_icon/24px/Phone.png",
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 5, left: 5),
              child: Text(
                textAlign: TextAlign.left,
                "*Không thể chỉnh sửa Số điện thoại",
                style: TextStyle(
                  color: const Color.fromARGB(150, 104, 112, 136),
                  fontFamily: "LD",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
