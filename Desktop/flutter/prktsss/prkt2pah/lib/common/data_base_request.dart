abstract class DataBaseRequest {
  static const String tableRole = 'Role';
  static const String tableUser = 'User';
  static const String tableCar = 'Car';
  static const String tableDvigatel = 'Dvigatel';
  static const String tableKorobka = 'Korobka';
  static const String tableKorzina = 'Korzina';
  static const String tableMarka = 'Marka';
  static const String tablePostavshik = 'Postavshik';
  static const String tableZavod = 'Zavod';

  static const List<String> tableList = [
    tableRole,
    tableUser,
    tableCar,
    tableDvigatel,
    tableKorobka,
    tableKorzina,
    tableMarka,
    tablePostavshik,
    tableZavod,
  ];

  static const List<String> tableCreateList = [
    _createTableRole,
    _createTableUser,
    _createTableCar,
    _createTableDvigatel,
    _createTableKorobka,
    _createTableKorzina,
    _createTableMarka,
    _createTablePostavshik,
    _createTableZavod,
  ];

  static const String _createTableRole = '''
  CREATE TABLE $tableRole (
    id INTEGER NOT NULL,
    role TEXT NOT NULL UNIQUE, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';

  static const String _createTableUser = '''
    CREATE TABLE $tableUser (
    id INTEGER NOT NULL,
    surname TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL UNIQUE,
    otchestvo TEXT NOT NULL UNIQUE,
    login TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL, 
    id_role INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT), 
    FOREIGN KEY("id_role") REFERENCES "Role"("id"))
  ''';

  static const String _createTableDvigatel = '''
    CREATE TABLE $tableDvigatel (
    id INTEGER NOT NULL,
    name TEXT NOT NULL UNIQUE, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';

  static const String _createTableKorobka = '''
    CREATE TABLE $tableKorobka (
    id INTEGER NOT NULL,
    name TEXT NOT NULL UNIQUE, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';
  
  static const String _createTableKorzina = '''
    CREATE TABLE $tableKorzina (
    id INTEGER NOT NULL,
    kolichestvo INT NOT NULL UNIQUE, 
    id_user INTEGER NOT NULL, 
    id_car INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT),
    FOREIGN KEY("id_user") REFERENCES "User"("id"),
    FOREIGN KEY("id_car") REFERENCES "Car"("id"))
    ''';
  
  static const String _createTableCar = '''
    CREATE TABLE $tableCar (
    id INTEGER NOT NULL,
    color TEXT NOT NULL, 
    weight INT NOT NULL, 
    type TEXT NOT NULL, 
    vmestimost INT NOT NULL, 
    id_marka INTEGER NOT NULL, 
    id_dvigatel INTEGER NOT NULL, 
    id_postavshik INTEGER NOT NULL, 
    id_zavod INTEGER NOT NULL, 
    id_korobka INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT), 
    FOREIGN KEY("id_marka") REFERENCES "Marke"("id"), 
    FOREIGN KEY("id_dvigatel") REFERENCES "Dvigatel"("id"), 
    FOREIGN KEY("id_postavshik") REFERENCES "Postavshik"("id"),
    FOREIGN KEY("id_zavod") REFERENCES "Zavod"("id"),
    FOREIGN KEY("id_korobka") REFERENCES "Korobka"("id"))
  ''';

  static const String _createTableMarka = '''
    CREATE TABLE $tableMarka (
    id INTEGER NOT NULL,
    name INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';

  static const String _createTablePostavshik = '''
    CREATE TABLE $tablePostavshik (
    id INTEGER NOT NULL,
    name INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';

  static const String _createTableZavod = '''
    CREATE TABLE $tableZavod (
    id INTEGER NOT NULL,
    name INTEGER NOT NULL, 
    PRIMARY KEY("id" AUTOINCREMENT))
  ''';
  static String deleteTable(String table) => 'DROP TABLE $table';
}