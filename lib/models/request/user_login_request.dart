class UserLoginRequest {
  final String email;
  final String password;

  UserLoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
