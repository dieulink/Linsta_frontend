// import 'package:flutter/material.dart';
// import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
// import 'package:linsta_app/screens/account_screens/widgets/app_bar_profile.dart';
// import 'package:linsta_app/screens/account_screens/widgets/button_edit_name.dart';
// import 'package:linsta_app/screens/account_screens/widgets/text_edit.dart';
// import 'package:linsta_app/ui_values.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditPhonePage extends StatefulWidget {
//   const EditPhonePage({super.key});

//   @override
//   State<EditPhonePage> createState() => _EditPhonePageState();
// }

// class _EditPhonePageState extends State<EditPhonePage> {
//   String phone = "";
//   String id = "";

//   @override
//   Future<void> _loadUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       phone = prefs.getString('phone') ?? 'Không có';
//       id = prefs.getString('id') ?? 'Không có';
//     });
//   }

//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final nameController = TextEditingController();
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBarProfile(name: "Tên người dùng"),
//       body: Container(
//         padding: EdgeInsets.all(15),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 1,
//                 margin: EdgeInsets.only(top: 10, bottom: 20),
//                 color: borderColor,
//               ),
//               SizedBox(height: 30),
//               Container(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "* Chỉnh sửa số điện thoại",
//                   style: TextStyle(
//                     color: textColor2,
//                     fontFamily: "LD",
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 child: TextEdit(hintText: phone, controller: nameController),
//               ),
//               SizedBox(height: 20),
//               ButtonEditName(text: "Chỉnh sửa"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
