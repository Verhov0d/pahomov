import '../../domain/entity/zavod_entity.dart';

class Zavod extends ZavodEntity {
  late int id;
  final String name;

  Zavod({required this.name}) : super(name: name);

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory Zavod.toFromMap(Map<String, dynamic> json) {
    return Zavod(name: json['name']);
  }
}