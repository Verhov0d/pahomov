import 'package:dartz/dartz.dart';
import '../../core/exception/failure.dart';
import '../entity/role_entity.dart';

abstract class AuthRepositories {
  String get table;

  Future<Either<Failure, RoleEnum>> signIn(String login, String password);

  Future<Either<Failure, bool>> signUp(String login, String password);
}