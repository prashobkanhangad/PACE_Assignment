import 'package:hive_flutter/adapters.dart';
 part 'model.g.dart';
@HiveType(typeId: 1)
class Newsmodel {
  @HiveField(0)
  final String newstitle;

  @HiveField(1)
  final String sourse;

  @HiveField(2)
  final String imgurl;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String date;

  Newsmodel(
      {required this.date,
      required this.description,
      required this.imgurl,
      required this.newstitle,
      required this.sourse});
}
