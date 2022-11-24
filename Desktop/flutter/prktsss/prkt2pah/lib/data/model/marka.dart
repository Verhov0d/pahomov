import '../../domain/entity/marka_entity.dart';

class Marka extends MarkaEntity {
  late int id;
  final String name;

  Marka({required this.name}) : super(name: name);

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory Marka.toFromMap(Map<String, dynamic> json) {
    return Marka(name: json['name']);
  }
}