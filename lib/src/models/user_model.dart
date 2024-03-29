import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? celular;
  String? cpf;
  String? password;
  String? token;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.celular,
    this.cpf,
    this.password,
    this.token,
  });

  toMap() {
    return {
      'fullname': name,
      'email': email,
      'phone': celular,
      'cpf': cpf,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      name: map["fullname"],
      email: map['email'],
      celular: map['phone'],
      cpf: map['cpf'],
      token: map['token'],
    );
  }

  toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, celular: $celular, cpf: $cpf, senha: $password, token: $token)';
  }
}
