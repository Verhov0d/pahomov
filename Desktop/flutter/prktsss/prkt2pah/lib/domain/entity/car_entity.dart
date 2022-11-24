class CarEntity {
  late int id;
  final String color;
  final int weight;
  final String type;
  final int vmestimost;
  late int idMarka;
  late int idDvigatel;
  late int idPostavshik;
  late int idZavod;
  late int idKorobka;


  CarEntity({
    required this.color,
    required this.weight,
    required this.type,
    required this.vmestimost,
    required this.idMarka,
    required this.idDvigatel,
    required this.idPostavshik,
    required this.idZavod,
    required this.idKorobka,});
}