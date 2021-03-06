import 'package:hive_flutter/adapters.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;
  @HiveField(3)
  final image;
  @HiveField(4)
  final String gender;
  @HiveField(5)
  final String place;
  StudentModel(
      {required this.name,
      required this.age,
      this.id,
      this.image,
      required this.gender,
      required this.place});
}
