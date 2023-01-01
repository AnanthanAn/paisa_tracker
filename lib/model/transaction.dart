import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa_tracker/model/player.dart';

part 'transaction.g.dart';

@HiveType(typeId: 1)
class Transaction extends HiveObject{
  @HiveField(0)
  late DateTime dateTime;
  
  @HiveField(1)
  late double rentAmount;
  
  @HiveField(2)
  late double collectedAmount;
  
  @HiveField(3)
  late List<Player> playersPlayed;
  
  @HiveField(4)
  late List<Player> playersPaid;
}