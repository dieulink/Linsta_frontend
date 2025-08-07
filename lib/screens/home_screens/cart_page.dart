import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:linsta_app/models/response/cart_response.dart';
import 'package:linsta_app/screens/home_screens/widgets/app_bar_cart_custom.dart';
import 'package:linsta_app/screens/home_screens/widgets/item_cart.dart';
import 'package:linsta_app/services/cart_service.dart';
import 'package:linsta_app/ui_values.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartResponse? cartResponse;
  bool isLoading = true;
  Set<int> selectedProductIds = {};
  int totalPrice = 0;
  int totalQuantity = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userIdString = prefs.getString('userId');
    if (userIdString == null) return;

    final userId = int.tryParse(userIdString);
    if (userId == null) return;

    final response = await CartService.fetchCart(userId);
    setState(() {
      cartResponse = response;
      isLoading = false;
    });
  }

  void updateTotalPrice() {
    final selectedItems = cartResponse!.cartItems
        .where((item) => selectedProductIds.contains(item.productId))
        .toList();

    int total = 0;
    for (var item in selectedItems) {
      total += item.price * item.quantity;
    }

    setState(() {
      totalPrice = total;
    });
  }

  void updateTotalQuantity() {
    final selectedItems = cartResponse!.cartItems
        .where((item) => selectedProductIds.contains(item.productId))
        .toList();

    int total = 0;
    for (var item in selectedItems) {
      total += item.quantity;
    }

    setState(() {
      totalQuantity = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBarCartCustom(),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (cartResponse == null || cartResponse!.cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBarCartCustom(),
        body: Center(
          child: Text(
            "Giỏ hàng trống",
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

    return Scaffold(
      backgroundColor: white,
      appBar: AppBarCartCustom(),
      body: ListView.builder(
        //padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        itemCount: cartResponse!.cartItems.length,
        itemBuilder: (context, index) {
          final item = cartResponse!.cartItems[index];
          return Column(
            children: [
              Container(height: 1, color: backgroudColor),
              CheckboxListTile(
                value: selectedProductIds.contains(item.productId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedProductIds.add(item.productId);
                    } else {
                      selectedProductIds.remove(item.productId);
                    }
                    updateTotalPrice();
                    updateTotalQuantity();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: mainColor,
                checkColor: Colors.white,
                title: ItemCart(
                  imgPath: item.imageUrl,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                  productId: item.productId,
                  onDeleteSuccess: () {
                    setState(() {
                      cartResponse!.cartItems.removeAt(index);
                    });
                  },
                  onIncreaseSuccess: () async {
                    await loadCart();
                    updateTotalPrice();
                    updateTotalQuantity();
                  },
                  onDecreaseSuccess: () async {
                    await loadCart();
                    updateTotalPrice();
                    updateTotalQuantity();
                  },
                ),
              ),
            ],
          );
        },
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
                  "Tổng tạm tính",
                  style: TextStyle(
                    color: textColor2,
                    fontFamily: "LD",
                    fontSize: 13,
                  ),
                ),
                Text(
                  "${NumberFormat("#,###", "vi_VN").format(totalPrice)}",
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
              width: getWidth(context) * 0.35,
              height: 50,
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: selectedProductIds.isEmpty
                    ? null
                    : () {
                        final selectedItems = cartResponse!.cartItems
                            .where(
                              (item) =>
                                  selectedProductIds.contains(item.productId),
                            )
                            .toList();

                        Navigator.pushNamed(
                          context,
                          "orderPage",
                          arguments: {
                            'items': selectedItems,
                            'totalPrice': totalPrice,
                            'totalQuantity': totalQuantity,
                            'isCart': 1,
                          },
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Đặt mua (${totalQuantity})",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "LD",
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
