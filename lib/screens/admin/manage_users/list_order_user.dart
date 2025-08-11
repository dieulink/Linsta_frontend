import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/order_response.dart';
import 'package:linsta_app/models/response/summary.dart';
import 'package:linsta_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_cart_custom.dart';
import 'package:linsta_app/services/admin_service.dart';
import 'package:linsta_app/services/order_service.dart';
import 'package:linsta_app/ui_values.dart';

class ListOrderUser extends StatefulWidget {
  const ListOrderUser({super.key});

  @override
  State<ListOrderUser> createState() => _ListOrderUserState();
}

class _ListOrderUserState extends State<ListOrderUser> {
  late Future<List<OrderResponse>> futureOrders;
  late Summary summary;
  late int userId;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['id'] != null) {
      userId = args['id'];
    }
    futureOrders = AdminService().getOrdersByUserId(userId);
    loadSummary();
  }

  void loadSummary() async {
    try {
      summary = await AdminService().getSummaryByUserId(userId);
      setState(() {
        summary = summary;
      });
    } catch (e) {
      print('Lỗi khi lấy $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Danh sách đơn hàng"),
      body: FutureBuilder<List<OrderResponse>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Đơn hàng trống",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final orders = snapshot.data!;

          if (orders.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Đơn hàng trống",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tổng số đơn hàng: ${summary.totalOrders}",
                      style: TextStyle(
                        color: textColor1,
                        fontFamily: "LD",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Tổng số sản phẩm đã mua: ${summary.totalQuantity}",
                      style: TextStyle(
                        color: textColor1,
                        fontFamily: "LD",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Tổng số tiền đã mua: ${NumberFormat("#,###", "vi_VN").format(summary.totalAmount)} vnđ",
                      style: TextStyle(
                        color: textColor1,
                        fontFamily: "LD",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(7),
                        ),

                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "orderDetailPage",
                              arguments: order.id,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Người nhận: ${order.receiveName}",
                                style: TextStyle(
                                  color: textColor3,
                                  fontFamily: "LD",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Nơi nhận: ${order.receiveAddress}",
                                style: TextStyle(
                                  color: textColor3,
                                  fontFamily: "LD",
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Giá tiền: ${NumberFormat("#,###", "vi_VN").format(order.totalPrice)}",
                                    style: TextStyle(
                                      color: textColor3,
                                      fontFamily: "LD",
                                      fontSize: 13,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${order.status}",
                                    style: TextStyle(
                                      color: textColor3,
                                      fontFamily: "LD",
                                      fontSize: 13,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
