import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cartResponse == null || cartResponse!.cartItems.isEmpty) {
      return const Center(child: Text('Giỏ hàng trống'));
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
                  onIncreaseSuccess: () {
                    setState(() {
                      item.quantity = item.quantity + 1;
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              print("Mua hàng");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Đặt mua ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
