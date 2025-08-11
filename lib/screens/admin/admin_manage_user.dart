import 'package:flutter/material.dart';
import 'package:linsta_app/models/response/user.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/admin/widgets/app_bar_user.dart';
import 'package:linsta_app/screens/admin/widgets/item_user.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/ui_values.dart';

class AdminManageUser extends StatefulWidget {
  const AdminManageUser({super.key});

  @override
  State<AdminManageUser> createState() => _AdminManageUserState();
}

class _AdminManageUserState extends State<AdminManageUser> {
  final AdminService adminService = AdminService();
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    try {
      List<User> fetchUsers = await adminService.getUsers();
      setState(() {
        users = fetchUsers;
      });
      print('Số user lấy được: ${users.length}');
    } catch (e) {
      print('Lỗi khi lấy user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUser(hintText: "Nhập ID người dùng ..."),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            User user = users[index];
            return ItemUser(
              id: user.id,
              role: user.role.name,
              name: user.name,
              email: user.email,
              phone: user.phone,
              address: user.address.address,
            );
          },
        ),
      ),
    );
  }
}
