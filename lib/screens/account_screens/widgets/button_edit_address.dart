import 'package:flutter/material.dart';
import 'package:linsta_app/models/request/edit_address_request.dart';
import 'package:linsta_app/services/user_service.dart';

import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonEditAddress extends StatelessWidget {
  final String text;
  final TextEditingController AddressController;
  const ButtonEditAddress({
    super.key,
    required this.text,
    required this.AddressController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        String? userId = prefs.getString('userId');

        if (token == null || userId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Không lấy được dữ liệu id = ${userId} token = ${token}",
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
              duration: const Duration(seconds: 2),
              elevation: 8,
            ),
          );
          return;
        }
        int id = int.parse(userId);
        final request = EditAddressRequest(
          id: id,
          newAddress: AddressController.text.trim(),
        );

        final response = await UserService.editAddress(request);

        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.download_done_rounded, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      response.message,
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
              duration: const Duration(seconds: 2),
              elevation: 8,
            ),
          );
          await prefs.setString('address', AddressController.text.trim());
          Navigator.pushNamed(context, "home");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Đổi địa chỉ thất bại",
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
              duration: const Duration(seconds: 2),
              elevation: 8,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: SizedBox(
        width: getWidth(context),
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: white,
              fontFamily: "LD",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
