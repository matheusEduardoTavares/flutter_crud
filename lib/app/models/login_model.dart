import 'dart:convert';

class LoginModel {
  final String password;
  final String login;  

  LoginModel({
    required this.password,
    required this.login,
  });

  Map<String, dynamic> toMap() {
    return {
      'senha': password,
      'login': login,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      password: map['senha'] ?? '',
      login: map['login'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));
}
