import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/button_edit_name.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/text_edit.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  String name = "";
  String id = "";

  @override
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Không có';
      id = prefs.getString('userId') ?? 'Không có';
    });
  }

  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarProfile(name: "Tên người dùng"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 1,
                margin: EdgeInsets.only(top: 10, bottom: 20),
                color: borderColor,
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Chỉnh sửa tên",
                  style: TextStyle(
                    color: textColor2,
                    fontFamily: "LD",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(hintText: name, controller: nameController),
              ),
              SizedBox(height: 20),
              ButtonEditName(text: "Chỉnh sửa", nameController: nameController),
            ],
          ),
        ),
      ),
    );
  }
}
