import 'package:flutter/material.dart';

import '../models/player.dart';

class GameProvider extends ChangeNotifier {
  Set<Player> players = <Player>{};

  void addPlayers(List<Player> list) {
    players.clear();
    players.addAll(list);
    notifyListeners();
  }

  void removePlayer(Player? player) {
    if (player == null) return;
    players.remove(player);
    notifyListeners();
  }
}
