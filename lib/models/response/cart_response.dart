import 'package:linsta_app/models/response/cart_item_model.dart';

class CartResponse {
  final List<CartItemModel> cartItems;
  final int total;

  CartResponse({required this.cartItems, required this.total});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final items = (json['cartItems'] as List)
        .map((item) => CartItemModel.fromJson(item))
        .toList();

    return CartResponse(cartItems: items, total: json['total']);
  }
}
