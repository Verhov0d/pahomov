import '../../domain/entity/korzina_entity.dart';

class Korzina extends KorzinaEntity {
  Korzina({
    required super.kolichestvo,
    required super.idUser,
    required super.idCar,
  });

  Map<String, dynamic> toMap() {
    return {
      'kolichestvo': kolichestvo,
      'id_user': idUser,
      'id_car': idCar,
    };
  }

  factory Korzina.toFromMap(Map<String, dynamic> json) {
    return Korzina(
        kolichestvo: json['kolichestvo'],
        idUser: json['id_user'],
        idCar: json['id_car']);
  }
}