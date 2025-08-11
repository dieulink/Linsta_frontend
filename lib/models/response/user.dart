import 'package:linsta_app/models/response/role.dart';
import 'package:linsta_app/models/response/user_address.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final Role role;
  final UserAddress address;
  final DateTime createdAt;
  final DateTime? deletedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.role,
    required this.address,
    required this.createdAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      role: Role.fromJson(json['role']),
      address: UserAddress.fromJson(json['address']),
      createdAt: DateTime.parse(json['createdAt']),
      deletedAt: json['deletedAt'] != null
          ? DateTime.parse(json['deletedAt'])
          : null,
    );
  }
}
