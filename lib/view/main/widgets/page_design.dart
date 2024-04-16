import 'dart:ui';

import 'package:flutter/material.dart';

List<Widget> pageDesign() => [
      Positioned(
        left: -50,
        top: 150,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-.05),
          child: Container(
            width: 250,
            height: 80,
            decoration: _decoration().copyWith(color: Colors.tealAccent[100]),
          ),
        ),
      ),
      Positioned(
        left: -50,
        top: 50,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-.05),
          child: Container(
            width: 250,
            height: 80,
            decoration: _decoration().copyWith(color: Colors.amber[100]),
          ),
        ),
      ),
      Positioned(
        left: -50,
        top: 250,
        child: RotationTransition(
          turns: const AlwaysStoppedAnimation(-.05),
          child: Container(
            width: 250,
            height: 80,
            decoration: _decoration().copyWith(color: Colors.red[100]),
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: const SizedBox(),
      ),
    ];

BoxDecoration _decoration() {
  return BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(50)),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade200,
        blurRadius: 10,
        spreadRadius: 6,
      ),
      BoxShadow(
        color: Colors.grey.shade300,
        blurRadius: 6,
        spreadRadius: 2,
        blurStyle: BlurStyle.inner,
      )
    ],
  );
}
