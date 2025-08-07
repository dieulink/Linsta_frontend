class OrderDetailResponse {
  final int productId;
  final int productPrice;
  final int quantity;

  OrderDetailResponse({
    required this.productId,
    required this.productPrice,
    required this.quantity,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      productId: json['productId'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
    );
  }
}
