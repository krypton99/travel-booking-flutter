class User {
  final int id;
  final String name;
  final String password;
  late final String phone;
  final String username;

  User({ required this.id, required this.name, required this.password, required this.phone, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      username: json['username'],
    );
  }

  Map toJson() {
    return {
      "id": id,
      "name": name,
      "password": password,
      "phone": phone,
      "username": username,
    };
  }
}
