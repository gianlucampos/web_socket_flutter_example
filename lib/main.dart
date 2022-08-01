import 'package:flutter/material.dart';

import 'home/home_page.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // home: const HomeStockSocket(title: 'Home'),
      home: const HomePage(),
    );
  }
}
