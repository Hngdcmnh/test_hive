import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 1)
class Car {
  @HiveField(0)
  final int idCar;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int idContact;

  Car({required this.idCar, required this.name, required this.idContact});

}
