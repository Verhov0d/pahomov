import '../../domain/entity/postavshik_entity.dart';

class Postavshik extends PostavshikEntity {
  late int id;
  final String name;

  Postavshik({required this.name}) : super(name: name);

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory Postavshik.toFromMap(Map<String, dynamic> json) {
    return Postavshik(name: json['name']);
  }
}