class CartItemModel {
  final int productId;
  final String name;
  final String imageUrl;
  final int price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'];
    return CartItemModel(
      productId: product['id'],
      name: product['name'],
      imageUrl: product['imageUrl'],
      price: product['price'],
      quantity: json['quantity'],
    );
  }
}
