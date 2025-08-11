class UserAddress {
  final int id;
  final String address;

  UserAddress({required this.id, required this.address});

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(id: json['id'], address: json['address']);
  }
}
