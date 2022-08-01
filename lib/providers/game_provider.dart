import 'package:flutter/material.dart';

import '../models/player.dart';

class GameProvider extends ChangeNotifier {
  Set<Player> players = <Player>{};

  void addPlayer(Player player) {
    if (!players.any((p) => p.name == player.name)) {
      players.add(player);
      notifyListeners();
    }
  }

  void removePlayer(Player? player) {
    if (player == null) return;
    players.remove(player);
    notifyListeners();
  }
}
