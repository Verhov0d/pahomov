import 'dart:io';

import 'package:conduit/conduit.dart';
import 'package:dart_pr1/model/user.dart';
import 'package:dart_pr1/utils/app_response.dart';
import 'package:dart_pr1/utils/app_utils.dart';

class AppUserController extends ResourceController {
  AppUserController(this.managedContext);

  final ManagedContext managedContext;

  @Operation.get()
  Future<Response> getProfile(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
  ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final user = await managedContext.fetchObjectWithID<User>(id);
      user!.removePropertiesFromBackingMap(['refreshToken', 'accessToken']);
      return AppResponse.ok(
        message: 'Профил получен', body: user.backing.contents
      );
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка в получении профиля');
    }
  }

  @Operation.post()
  Future<Response> updateProfile(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.body() User user,
  ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final fUser = await managedContext.fetchObjectWithID<User>(id);
      final qUpdateUser = Query<User>(managedContext)
        ..where((element) => element.id)
          .equalTo(id)
        ..values.userName = user.userName ?? fUser!.userName
        ..values.email = user.email ?? fUser!.email;

      await qUpdateUser.updateOne();
      final findUser = await managedContext.fetchObjectWithID<User>(id);
      findUser!.removePropertiesFromBackingMap(['refreshToken', 'accessToken']);

      return AppResponse.ok(
        message: 'Данные обнавлены',
        body: findUser.backing.contents,
      );
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка в обновлении данных');
    }
  }

  @Operation.put()
  Future<Response> updatePassword(
    @Bind.header(HttpHeaders.authorizationHeader) String header,
    @Bind.query('newPassword') String newPassword,
    @Bind.query('oldPassword') String oldPassword,
  ) async {
    try {
      final id = AppUtils.getIdFromHeader(header);
      final qFindUser = Query<User>(managedContext)
        ..where((element) => element.id).equalTo(id)
        ..returningProperties(
          (element) => [
            element.salt, 
            element.hashPassword,
          ]
        );

      final fUser = await qFindUser.fetchOne();
      final oldHashPassword = generatePasswordHash(oldPassword, fUser!.salt ?? "");

      if (oldHashPassword != fUser.hashPassword) {
        return AppResponse.badrequest(
          message: 'Старый пароль неверный'
        );
      }
      
      final newHashPassword = generatePasswordHash(newPassword, fUser.salt ?? "");
      final qUpdateUser = Query<User>(managedContext)
        ..where((element) => element.id).equalTo(id)
        ..values.hashPassword = newHashPassword;

      await qUpdateUser.fetchOne();

      return AppResponse.ok(body: 'Пароль обновлен');
    } catch (e) {
      return AppResponse.serverError(e, message: 'Ошибка в обновлении пароля!');
    }
  }
}