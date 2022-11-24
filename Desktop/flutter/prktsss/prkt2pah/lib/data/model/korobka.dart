import '../../domain/entity/korobka_entity.dart';

class Korobka extends KorobkaEntity {
  late int id;
  final String name;

  Korobka({required this.name}) : super(name: name);

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory Korobka.toFromMap(Map<String, dynamic> json) {
    return Korobka(name: json['name']);
  }
}