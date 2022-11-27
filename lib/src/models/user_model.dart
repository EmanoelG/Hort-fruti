import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? celular;
  String? cpf;
  String? senha;
  String? toke;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.celular,
    this.cpf,
    this.senha,
    this.toke,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': name,
      'email': email,
      'phone': celular,
      'cpf': cpf,
      'senha': senha,
      'toke': toke,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      name: map["fullname"],
      email: map['email'],
      celular: map['phone'],
      cpf: map['cpf'],
      toke: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, celular: $celular, cpf: $cpf, senha: $senha, toke: $toke)';
  }
}
