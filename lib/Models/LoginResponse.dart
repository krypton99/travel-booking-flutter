class LoginResponse{
  final int id;
  final String name;
  final String username;
  final String phone;
  final String token;

  LoginResponse({required this.id, required this.name, required this.username, required this.phone, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      token: json['token'],
    );
  }
}