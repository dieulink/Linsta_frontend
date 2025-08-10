import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/button_edit_address.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/button_edit_email.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/button_edit_name.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/text_edit.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String address = "";
  String id = "";

  @override
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address') ?? 'Không có';
      id = prefs.getString('id') ?? 'Không có';
    });
  }

  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final AddressController = TextEditingController();
    return Scaffold(
      appBar: AppBarProfile(name: "Chỉnh sửa địa chỉ"),
      backgroundColor: white,
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
                  "* Chỉnh sửa địa chỉ",
                  style: TextStyle(
                    color: textColor2,
                    fontFamily: "LD",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(
                  hintText: address,
                  controller: AddressController,
                ),
              ),
              SizedBox(height: 20),
              ButtonEditAddress(
                AddressController: AddressController,
                text: "Cập nhật",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
