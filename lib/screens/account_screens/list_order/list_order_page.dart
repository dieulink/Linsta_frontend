import 'package:flutter/material.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/tag_account.dart';
import 'package:linsta_app/ui_values.dart';

class ListOrderPage extends StatelessWidget {
  const ListOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarProfile(name: "Quản lý đơn hàng"),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 1,
              margin: EdgeInsets.only(top: 40),
              color: borderColor,
            ),
            TagAccount(
              imgPath: "assets/icons/system_icon/24px/processing.png",
              name: "Đang xử lý",
              ontap: "processingPage",
            ),
            TagAccount(
              imgPath: "assets/icons/system_icon/24px/shipping.png",
              name: "Đang vận chuyển",
              ontap: "shippingPage",
            ),
            TagAccount(
              imgPath: "assets/icons/system_icon/24px/done.png",
              name: "Đã hoàn thành",
              ontap: "doneOrderPage",
            ),
          ],
        ),
      ),
    );
  }
}
