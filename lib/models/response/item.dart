class Item {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String descImages;
  final int stock;
  final DateTime createdAt;
  final String? deletedAt;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.descImages,
    required this.stock,
    required this.createdAt,
    this.deletedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      descImages: json['descImages'],
      stock: json['stock'],
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt: json['deletedAt'],
    );
  }
}
