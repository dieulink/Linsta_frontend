// import 'package:flutter/material.dart';
// import 'package:linsta_app/screens/account_screens/profile/profile_page.dart';
// import 'package:linsta_app/screens/account_screens/widgets/app_bar_profile.dart';
// import 'package:linsta_app/screens/account_screens/widgets/button_edit_email.dart';
// import 'package:linsta_app/screens/account_screens/widgets/button_edit_name.dart';
// import 'package:linsta_app/screens/account_screens/widgets/text_edit.dart';
// import 'package:linsta_app/ui_values.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class EditEmailPage extends StatefulWidget {
//   const EditEmailPage({super.key});

//   @override
//   State<EditEmailPage> createState() => _EditEmailPageState();
// }

// class _EditEmailPageState extends State<EditEmailPage> {
//   String email = "";
//   String id = "";

//   @override
//   Future<void> _loadUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       email = prefs.getString('email') ?? 'Không có';
//       id = prefs.getString('id') ?? 'Không có';
//     });
//   }

//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final emailController = TextEditingController();
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBarProfile(name: "Địa chỉ Email"),
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
//                   "* Chỉnh sửa Email",
//                   style: TextStyle(
//                     color: textColor2,
//                     fontFamily: "LD",
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Container(
//                 child: TextEdit(hintText: email, controller: emailController),
//               ),
//               SizedBox(height: 20),
//               ButtonEditEmail(text: "Chỉnh sửa"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
