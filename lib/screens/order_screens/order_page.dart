import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/request/order_detail_request.dart';
import 'package:linsta_app/models/request/order_request.dart';
import 'package:linsta_app/models/response/cart_item_model.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_cart.dart';
import 'package:linsta_app/screens/order_screens/widgets/app_bar_order.dart';
import 'package:linsta_app/screens/order_screens/widgets/item_order.dart';
import 'package:linsta_app/services/order_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String receiveName = "";
  String receiveAddress = "";
  String receivePhone = "";
  late int userId;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('userId') ?? 'Không lấy được id';
    setState(() {
      receiveName = prefs.getString('name') ?? 'Không lấy được name';
      receivePhone = prefs.getString('phone') ?? 'Không lấy được sđt';
      receiveAddress = prefs.getString('address') ?? 'Không lấy được địa chỉ';
      userId = int.parse(id);
    });
  }

  Future<void> _loadReceiveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      receiveName = prefs.getString('receiveName') ?? "không có";
      receivePhone = prefs.getString('receivePhone') ?? "không có";
      receiveAddress = prefs.getString('receiveAddress') ?? "không có";
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(body: Center(child: Text("Không có dữ liệu")));
    }

    final List<CartItemModel> items = List<CartItemModel>.from(args['items']);
    final int totalPrice = args['totalPrice'];
    final int totalQuantity = args['totalQuantity'];
    final int isCart = args['isCart'];
    final int shipCost = 30000;
    return Scaffold(
      appBar: AppBarOrder(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/system_icon/24px/Location.png',
                        color: mainColor,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${receiveName}",
                            style: TextStyle(
                              color: textColor3,
                              fontFamily: "LD",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${receivePhone}",
                            style: TextStyle(
                              color: textColor3,
                              fontFamily: "LD",
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${receiveAddress}",
                            style: TextStyle(
                              color: textColor3,
                              fontFamily: "LD",
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        "editReceiveNamePage",
                      );
                      if (result == true) {
                        _loadReceiveUser();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Sửa",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Column(
                children: items.map((item) {
                  return ItemOrder(
                    imgPath: item.imageUrl ?? "assets/imgs/default.jpg",
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                    productId: item.productId,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      color: textColor3,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Thanh toán khi nhận hàng",
                    style: TextStyle(
                      color: textColor3,
                      fontFamily: "LD",
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(
                      color: textColor3,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền hàng",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(totalPrice)}",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền phí vận chuyển",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(shipCost)}",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container(height: 1, color: backgroudColor),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng thanh toán",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(totalPrice + 30000)}",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tổng cộng",
                  style: TextStyle(
                    color: textColor3,
                    fontFamily: "LD",
                    fontSize: 13,
                  ),
                ),
                Text(
                  "${NumberFormat("#,###", "vi_VN").format(totalPrice + 30000)}",
                  style: TextStyle(
                    color: red,
                    fontFamily: "LD",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Container(
              width: getWidth(context) * 0.3,
              height: 50,
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  final orderService = OrderService();

                  List<OrderDetailRequest> orderItems = items.map((item) {
                    return OrderDetailRequest(
                      productId: item.productId,
                      productPrice: item.price,
                      quantity: item.quantity,
                    );
                  }).toList();
                  final request = OrderRequest(
                    userId: userId,
                    quantity: totalQuantity,
                    totalPrice: totalPrice,
                    receiveAddress: receiveAddress,
                    receiveName: receiveName,
                    receivePhone: receivePhone,
                    shipCost: 30000,
                    isCart: isCart,
                    payMethodId: 1,
                    items: orderItems,
                  );
                  bool success = await orderService.createOrder(request);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.download_done_rounded, color: white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Đặt hàng thành công",
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
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error_outline, color: white),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Đặt hàng thất bại",
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
                  Navigator.pushNamed(context, "home");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Đặt hàng",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
