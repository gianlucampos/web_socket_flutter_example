import 'dart:convert';
import 'dart:developer';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../providers/globals.dart';
import '../models/player.dart';

class WebSocketRepository {
  StompClient? stompClient;
  final socketUrl = 'http://localhost:8080/ws-message';

  void initConfig() {
    stompClient ??= StompClient(
        config: StompConfig.SockJS(
      url: socketUrl,
      onConnect: onConnect,
      onWebSocketDone: () => log('Done', time: DateTime.now()),
      onWebSocketError: (dynamic error) => log(error.toString()),
    ));

    stompClient!.activate();
  }

  void onConnect(StompFrame frame) {
    //Lista jogadores
    stompClient!.subscribe(
      destination: '/topic/users',
      callback: (StompFrame frame) {
        final json = jsonDecode(frame.body!);
        final List<Player> players = json
            .map<Player>((p) => Player.fromMap(Map<String, String>.from(p)))
            .toList();
        gameProvider.addPlayers(players);
      },
    );
    stompClient!.send(destination: '/app/list');
  }

  void deactivete() {
    stompClient!.deactivate();
  }
}
