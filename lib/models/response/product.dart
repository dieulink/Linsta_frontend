class Product {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] as num).toInt(),
      stock: (json['stock'] as num).toInt(),
    );
  }
}
