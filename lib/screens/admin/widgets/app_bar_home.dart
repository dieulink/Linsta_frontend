import 'package:flutter/material.dart';
import 'package:linsta_app/screens/home_screens/home.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  const AppBarHome({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 30, left: 10, right: 25, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.logout_rounded, color: mainColor),
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: white,
                      title: Text(
                        'Xác nhận đăng xuất',
                        style: TextStyle(
                          color: textColor1,
                          fontFamily: "LD",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        'Bạn có chắc muốn đăng xuất không?',
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text(
                                'Hủy',
                                style: TextStyle(
                                  color: textColor1,
                                  fontFamily: "LD",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                'Đăng xuất',
                                style: TextStyle(
                                  color: textColor1,
                                  fontFamily: "LD",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushReplacementNamed(context, 'loginPage');
                  }
                },
              ),
              Container(
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      name,
                      style: TextStyle(
                        color: mainColor,
                        fontFamily: "LD",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("profilePage");
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(100),
                child: Icon(Icons.account_circle, size: 40, color: mainColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
