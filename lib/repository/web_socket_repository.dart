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
    // stompClient!.send(destination: '/app/list');
    //TODO adicionar todos os subscribes para atualizacao em tempo real
    // stompClient!.subscribe(
    //     destination: '/topic/newMember',
    //     callback: (StompFrame frame) {
    //       var json = frame.body!;
    //       Player player = Player.fromMap(jsonDecode(json));
    //       gameProvider.addPlayer(player);
    //     });

    //Lista jogadores
    stompClient!.subscribe(
      destination: '/topic/users',
      callback: (StompFrame frame) {
        final json = jsonDecode(frame.body!);
        final List<Player> players = json
            .map<Player>((p) => Player.fromMap(Map<String, String>.from(p)))
            .toList();
        for (var player in players) {
          gameProvider.addPlayer(player);
        }
      },
    );
    stompClient!.send(destination: '/app/list');
  }

  void deactivete() {
    stompClient!.deactivate();
  }
}
