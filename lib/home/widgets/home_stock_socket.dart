import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_socket/home/widgets/stock_list.dart';
import 'package:intl/intl.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../../models/stock.dart';

class HomeStockSocket extends StatefulWidget {
  final String title;

  const HomeStockSocket({Key? key, required this.title}) : super(key: key);

  @override
  HomeStockSocketState createState() => HomeStockSocketState();
}

class HomeStockSocketState extends State<HomeStockSocket> {
  StompClient? stompClient;
  List<Stock> stockList = [];
  final socketUrl = 'http://localhost:8080/ws-message';

  void onConnect(StompFrame frame) {
    // stompClient!.subscribe(
    //     destination: '/topic/abobora',
    //     callback: (StompFrame frame) {
    //       log('praia');
    //       if (frame.body != null) {
    //         Map<String, dynamic> obj = json.decode(frame.body!);
    //         List<Stock> stocks = <Stock>[];
    //
    //         for (int i = 0; i < obj['stock'].length; i++) {
    //           Stock stock = Stock(
    //               company: obj['stock'][i]['name'],
    //               symbol: obj['stock'][i]['symbol'],
    //               price: obj['stock'][i]['price'],
    //               chg: obj['stock'][i]['chg']);
    //           stocks.add(stock);
    //         }
    //         setState(() => stockList = stocks);
    //       }
    //     });

    stompClient!.subscribe(
      destination: '/topic/abobora',
      callback: (StompFrame frame) {
      },
    );

    stompClient!.send(destination: '/app/hello', body: "dimuthu");
  }

  @override
  void initState() {
    super.initState();

    stompClient ??= StompClient(
        config: StompConfig.SockJS(
      url: socketUrl,
      onConnect: onConnect,
      onWebSocketDone: () => log('Done', time: DateTime.now()),
      onWebSocketError: (dynamic error) => log(error.toString()),
    ));

    stompClient!.activate();
  }

  @override
  void dispose() {
    stompClient!.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  const Expanded(
                    flex: 1,
                    child: Text(
                      "Watch List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      DateFormat('dd MMMM yyyy').format(DateTime.now()),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateFormat().add_jm().format(DateTime.now()),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      hintText: "Search",
                      prefix: const Icon(Icons.search),
                      fillColor: Colors.grey[800],
                      filled: true,
                      border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - 310,
                    child: StockList(
                      stocks: stockList,
                    )),
              )
            ],
          ),
        ),
      )
    ]));
  }
}
