import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player extends HiveObject{
  // @HiveField(0)
  // late int id;
  @HiveField(1)
  late String name;
}