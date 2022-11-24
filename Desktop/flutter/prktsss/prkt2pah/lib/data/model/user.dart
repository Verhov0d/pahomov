import 'package:prkt2pah/domain/entity/user_entity.dart';

import '../../domain/entity/role_entity.dart';

class User extends UserEntity {
  User(
      {required super.surname,
      required super.name,
      required super.otchestvo,
      required super.login,
      required super.password,
      required super.idRole});

  Map<String, dynamic> toMap() {
    return {
      'surname':surname,
      'name':name,
      'otchestvo':otchestvo,
      'login': login,
      'password': password,
      'id_role': idRole.id,
    };
  }

  factory User.toFromMap(Map<String, dynamic> json) {
    return User(
      surname: json['surname'],
      name: json['name'],
      otchestvo: json['otchestvo'],
      login: json['login'],
      password: json['password'],
      idRole: RoleEnum.values.firstWhere(
        (element) => element.id == (json['id_role'] as int),
      ), 
    );
  }
}