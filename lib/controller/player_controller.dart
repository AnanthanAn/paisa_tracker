import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/player.dart';

class PlayerController extends GetxController{
  List<Player> players = <Player>[].obs;

  @override
  void onInit() {
    fetchPlayersListFromHive();
    super.onInit();
  }

  Future fetchPlayersListFromHive() async{
    players.clear();
    var box =  Hive.box<Player>('players');
    players.addAll(box.values);
  }

  Future addPlayer(Player player) async{
    var box =  Hive.box<Player>('players');
    box.add(player);
    fetchPlayersListFromHive();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}