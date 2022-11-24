import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:prkt2pah/data/model/dvigatel.dart';
import 'package:prkt2pah/data/model/car.dart';
import 'package:prkt2pah/data/model/korobka.dart';
import 'package:prkt2pah/data/model/korzina.dart';
import 'package:prkt2pah/data/model/marka.dart';
import 'package:prkt2pah/data/model/postavshik.dart';
import 'package:prkt2pah/data/model/zavod.dart';
import 'package:prkt2pah/domain/entity/role_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../common/data_base_request.dart';
import '../../data/model/role.dart';
import '../../data/model/user.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper._instance();

  DataBaseHelper._instance();

  late final Directory _appDocumentDirectory;
  late final String _pathDB;
  late final Database database;
  final int _version = 1;

  Future<void> init() async {
    _appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();

    _pathDB = join(_appDocumentDirectory.path, 'car.db');

    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      var db = await databaseFactoryFfi.openDatabase(_pathDB,
          options: OpenDatabaseOptions(
            version: _version,
            onUpgrade: (db, oldVersion, newVersion) => onUpgradeTable(db),
            onCreate: (db, version) async {
              await onCreateTable(db);
            },
          ));
    } else {
      database = await openDatabase(_pathDB, version: _version,
          onCreate: (db, version) async {
        await onCreateTable(db);
      }, onUpgrade: ((db, oldVersion, newVersion) => onUpgradeTable(db)));
    }
  }

  Future<void> onCreateTable(Database db) async {
    for (var table in DataBaseRequest.tableCreateList) {
      await db.execute(table);
    }

    db.execute('PRAGMA foreign_keys=on');
    await onInitTable(db);
  }

  Future<void> onInitTable(Database db) async {
    try {
      db.insert(DataBaseRequest.tableRole, Role(role: "Администратор").toMap());
      db.insert(DataBaseRequest.tableRole, Role(role: "Пользователь").toMap());

      db.insert(
          DataBaseRequest.tableUser,
          User(
                  surname: "Иван",
                  name: "Иван",
                  otchestvo: "Иван",
                  login: "1",
                  password: "1",
                  idRole: RoleEnum.user)
              .toMap());
      db.insert(
          DataBaseRequest.tableUser,
          User(
                  surname: "Арбуз",
                  name: "Виктор",
                  otchestvo: "Олегович",
                  login: "9",
                  password: "9",
                  idRole: RoleEnum.admin)
              .toMap());

      db.insert(DataBaseRequest.tableMarka, Marka(name: "Жигуль").toMap());
      db.insert(DataBaseRequest.tableMarka, Marka(name: "Лада").toMap());
      db.insert(DataBaseRequest.tableMarka, Marka(name: "Рено").toMap());

      db.insert(DataBaseRequest.tablePostavshik, Postavshik(name: "Америка").toMap());
      db.insert(DataBaseRequest.tablePostavshik, Postavshik(name: "Китай").toMap());
      db.insert(DataBaseRequest.tablePostavshik, Postavshik(name: "Россия").toMap());
      db.insert(DataBaseRequest.tablePostavshik, Postavshik(name: "Памир").toMap());
      db.insert(DataBaseRequest.tablePostavshik, Postavshik(name: "Беларусь").toMap());

      db.insert(DataBaseRequest.tableZavod, Zavod(name: "Автострой").toMap());
      db.insert(DataBaseRequest.tableZavod, Zavod(name: "Машинострой").toMap());
      db.insert(DataBaseRequest.tableZavod, Zavod(name: "СтройАвто").toMap());

      db.insert(DataBaseRequest.tableDvigatel, Dvigatel(name: "спортивный а2").toMap());
      db.insert(DataBaseRequest.tableDvigatel, Dvigatel(name: "универсал 999").toMap());
      db.insert(DataBaseRequest.tableDvigatel, Dvigatel(name: "стандарт 01").toMap());

      db.insert(DataBaseRequest.tableKorobka, Korobka(name: "автомат 10").toMap());
      db.insert(DataBaseRequest.tableKorobka, Korobka(name: "механика 3").toMap());
      db.insert(DataBaseRequest.tableKorobka, Korobka(name: "механика спорт").toMap());

      db.insert(
          DataBaseRequest.tableCar,
          Car(
                  color: "чёрный",
                  weight: 500,
                  type: "легковой",
                  vmestimost: 5,
                  idDvigatel: 1,
                  idKorobka: 2,
                  idMarka: 2,
                  idPostavshik: 2,
                  idZavod: 5)
              .toMap());
      db.insert(
          DataBaseRequest.tableCar,
          Car(
                  color: "красный",
                  weight: 1500,
                  type: "грузовой",
                  vmestimost: 20,
                  idDvigatel: 2,
                  idKorobka: 1,
                  idMarka: 1,
                  idPostavshik: 1,
                  idZavod: 5)
              .toMap());

      db.insert(DataBaseRequest.tableKorzina, Korzina(kolichestvo: 1, idCar: 1, idUser: 1).toMap());
      db.insert(DataBaseRequest.tableKorzina, Korzina(kolichestvo: 2, idCar: 2, idUser: 2).toMap());

    } on DatabaseException catch (e) {}
  }

  Future<void> onUpgradeTable(Database db) async {
    var tables = await db.rawQuery('SELECT name FROM sqlite_master');

    for (var table in DataBaseRequest.tableCreateList) {
      if (tables.contains(table)) {
        await db.execute(DataBaseRequest.deleteTable(table));
      }
    }
    await onCreateTable(db);
  }

  Future<void> onDropDataBase() async {
    database.close();

    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      databaseFactoryFfi.deleteDatabase(_pathDB);
    } else {
      await deleteDatabase(_pathDB);
    }
  }
}