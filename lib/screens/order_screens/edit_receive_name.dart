import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/button_edit_name.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/text_edit.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditReceiveNamePage extends StatefulWidget {
  const EditReceiveNamePage({super.key});

  @override
  State<EditReceiveNamePage> createState() => _EditReceiveNamePageState();
}

class _EditReceiveNamePageState extends State<EditReceiveNamePage> {
  String name = "";
  String id = "";
  String phone = "";
  String address = "";

  @override
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Không có';
      id = prefs.getString('userId') ?? 'Không có';
      phone = prefs.getString('phone') ?? 'Không có';
      address = prefs.getString('address') ?? 'Không có';
    });
  }

  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarProfile(name: "Thông tin người nhận"),
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
              SizedBox(height: 10),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "*  Tên người nhận",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(hintText: name, controller: nameController),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Số điện thoại ",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(hintText: phone, controller: phoneController),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Địa chỉ",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(
                  hintText: address,
                  controller: addressController,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Vui lòng điền đầy đủ thông tin",
                                style: TextStyle(fontFamily: "LD"),
                              ),
                            ),
                          ],
                        ),

                        backgroundColor: textColor1,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(30),
                        duration: const Duration(seconds: 1),
                        elevation: 8,
                      ),
                    );
                  } else {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString(
                      'receiveName',
                      nameController.text.trim(),
                    );
                    await prefs.setString(
                      'receivePhone',
                      phoneController.text.trim(),
                    );
                    await prefs.setString(
                      'receiveAddress',
                      addressController.text.trim(),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.download_done_rounded, color: white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Cập nhật thành công",
                                style: TextStyle(fontFamily: "LD"),
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: textColor1,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.all(30),
                        duration: const Duration(seconds: 1),
                        elevation: 8,
                      ),
                    );

                    Navigator.pop(context, true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: SizedBox(
                  width: getWidth(context),
                  height: 60,
                  child: Center(
                    child: Text(
                      "Cập nhật",
                      style: TextStyle(
                        color: white,
                        fontFamily: "LD",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
