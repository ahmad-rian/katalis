class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'token': token,
    };
  }
}
