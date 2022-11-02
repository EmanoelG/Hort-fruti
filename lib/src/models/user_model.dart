import 'dart:convert';

class UserModel {
  String name;
  String email;
  String celular;
  String cpf;
  String senha;
  UserModel({
    required this.name,
    required this.email,
    required this.celular,
    required this.cpf,
    required this.senha,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? celular,
    String? cpf,
    String? senha,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      cpf: cpf ?? this.cpf,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'celular': celular,
      'cpf': cpf,
      'senha': senha,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      celular: map['celular'] ?? '',
      cpf: map['cpf'] ?? '',
      senha: map['senha'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, celular: $celular, cpf: $cpf, senha: $senha)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.celular == celular &&
        other.cpf == cpf &&
        other.senha == senha;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        celular.hashCode ^
        cpf.hashCode ^
        senha.hashCode;
  }
}
