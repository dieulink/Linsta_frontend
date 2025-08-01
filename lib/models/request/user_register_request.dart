class UserRegisterRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String address;

  UserRegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'address': address,
    };
  }

  factory UserRegisterRequest.fromJson(Map<String, dynamic> json) {
    return UserRegisterRequest(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
