import 'package:flutter/foundation.dart';

class UserResetPasswordRequest {
  final String email;
  final String password;
  final String otp;

  UserResetPasswordRequest({
    required this.email,
    required this.password,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'otp': otp};
  }

  factory UserResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return UserResetPasswordRequest(
      email: json['email'],
      password: json['password'],
      otp: json['otp'],
    );
  }
}
