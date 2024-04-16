import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:playfair/view/main/home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Playfair",
      debugShowCheckedModeBanner: false,
      home: Home(),
      scrollBehavior: CustomScrollBehavior(),
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.touch,
      };
}
