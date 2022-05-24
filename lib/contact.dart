import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final int idContact;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int numberCall;


  Contact({required this.name, required this.numberCall, required this.idContact});
}
