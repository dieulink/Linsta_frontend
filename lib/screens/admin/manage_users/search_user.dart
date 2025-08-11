import 'package:flutter/material.dart';
import 'package:linsta_app/models/response/user.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:linsta_app/screens/admin/widgets/item_user.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final TextEditingController _controller = TextEditingController();
  User? searchedUser;
  String? errorMessage;
  bool isLoading = false;

  void searchUser(String input) async {
    if (input.isEmpty) {
      setState(() {
        searchedUser = null;
        errorMessage = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      int id = int.parse(input);
      User user = await AdminService.getUserById(id);
      setState(() {
        searchedUser = user;
        errorMessage = null;
      });
    } catch (e) {
      setState(() {
        searchedUser = null;
        errorMessage = "Không tìm thấy người dùng ";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 60),
        child: AppBar(
          backgroundColor: white,
          title: const Text(
            "Tìm kiếm người dùng",
            style: TextStyle(
              color: textColor1,
              fontFamily: "LD",
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor1),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: mainColor, width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
              child: TextField(
                style: TextStyle(
                  color: textColor3,
                  fontFamily: "LD",
                  fontSize: 13,
                ),
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Nhập ID người dùng...",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search, color: mainColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
                onChanged: (value) {
                  searchUser(value);
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (isLoading) const CircularProgressIndicator(),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (searchedUser != null)
              Expanded(
                child: ListView(
                  children: [
                    ItemUser(
                      id: searchedUser!.id,
                      role: searchedUser!.role.name,
                      name: searchedUser!.name,
                      email: searchedUser!.email,
                      phone: searchedUser!.phone,
                      address: searchedUser!.address.address,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
