import 'package:prkt2pah/domain/entity/role_entity.dart';

class UserEntity {
  late int? id;
  final String? login;
  final String? password;
  final RoleEnum? idRole;

  bool isSelect;

  UserEntity(
      {this.id = 0,
      this.login,
      this.password = '',
      this.idRole,
      this.isSelect = false,});
}