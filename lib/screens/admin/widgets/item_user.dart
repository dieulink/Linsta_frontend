import 'package:flutter/material.dart';
import 'package:linsta_app/ui_values.dart';

class ItemUser extends StatelessWidget {
  final int id;
  final String role;
  final String name;
  final String email;
  final String phone;
  final String address;

  const ItemUser({
    super.key,
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "listOrderUser", arguments: {'id': id});
      },

      child: Container(
        height: 160,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "_ID: $id",
                  style: TextStyle(
                    fontFamily: "LD",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                  ),
                ),
                Text(
                  "Vai trò: $role",
                  style: TextStyle(
                    fontFamily: "LD",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              "Tên: $name",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor3,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Email: $email",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 13,
                color: textColor3,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 5),
            Text(
              "Số điện thoại: $phone",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 13,
                color: textColor3,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Địa chỉ: $address",
              style: TextStyle(
                fontFamily: "LD",
                fontSize: 13,
                color: textColor3,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
