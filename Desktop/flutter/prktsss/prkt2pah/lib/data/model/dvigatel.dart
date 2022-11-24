import '../../domain/entity/dvigatel_entity.dart';

class Dvigatel extends DvigatelEntity {
  late int id;
  final String name;

  Dvigatel({required this.name}) : super(name: name);

  Map<String, dynamic> toMap() {
    return {'name': name};
  }

  factory Dvigatel.toFromMap(Map<String, dynamic> json) {
    return Dvigatel(name: json['name']);
  }
}