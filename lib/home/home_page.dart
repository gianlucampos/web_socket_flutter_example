import 'package:flutter/material.dart';
import 'package:flutter_web_socket/repository/web_socket_repository.dart';

import '../providers/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WebSocketRepository webSocket = WebSocketRepository();

  @override
  void initState() {
    super.initState();
    gameProvider.addListener(() {
      setState(() {});
    });
    webSocket.initConfig();
  }

  @override
  void dispose() {
    super.dispose();
    webSocket.deactivete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildTextButton(
          text: "Connect",
          function: () {
            webSocket.stompClient!.activate();
          },
        ),
        buildTextButton(
          text: "Disconnect",
          function: () {
            webSocket.stompClient!.deactivate();
          },
        ),
        buildTextButton(
          text: "List players",
          function: () {
            webSocket.stompClient!.send(destination: '/app/list');
          },
        ),
        buildTextButton(
          text: "Add player",
          function: () {
            webSocket.stompClient!
                .send(destination: '/app/register', body: "Flavio");
          },
        ),
        buildTextButton(
          text: "Remove player",
          function: () {
            gameProvider.removePlayer(gameProvider.players.isNotEmpty
                ? gameProvider.players.first
                : null);
            webSocket.stompClient!
                .send(destination: '/app/unregister', body: "Gianluca");
          },
        ),
        Column(
          children: gameProvider.players.map((e) => Text(e.name)).toList(),
        )
      ],
    ));
  }

  TextButton buildTextButton(
      {required VoidCallback function, required String text}) {
    return TextButton(
      onPressed: () {
        function.call();
        super.setState(() {});
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
