import '../../domain/entity/car_entity.dart';

class Car extends CarEntity {
  Car({
    required super.color,
    required super.weight,
    required super.type,
    required super.vmestimost,
    required super.idMarka,
    required super.idDvigatel,
    required super.idPostavshik,
    required super.idZavod,
    required super.idKorobka,
  });

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'weight': weight,
      'type': type,
      'vmestimost': vmestimost,
      'id_marka': idMarka,
      'id_dvigatel': idDvigatel,
      'id_postavshik': idPostavshik,
      'id_zavod': idZavod,
      'id_korobka': idKorobka,
    };
  }

  factory Car.toFromMap(Map<String, dynamic> json) {
    return Car(
        color: json['color'],
        weight: json['weight'],
        type: json['type'],
        vmestimost: json['vmestimost'],
        idMarka: json['id_marka'],
        idDvigatel: json['id_dvigatel'],
        idPostavshik: json['id_postavshik'],
        idZavod: json['id_zavod'],
        idKorobka: json['id_korobka']);
  }
}