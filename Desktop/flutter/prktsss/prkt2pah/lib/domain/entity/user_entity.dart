import 'package:prkt2pah/domain/entity/role_entity.dart';

class UserEntity {
  late int id;
  final String surname;
  final String name;
  final String otchestvo;
  final String login;
  final String password;
  final RoleEnum idRole;

  UserEntity(
      {this.id = 0,
      required this.surname,
      required this.name,
      required this.otchestvo,
      required this.login,
      required this.password,
      required this.idRole});
}