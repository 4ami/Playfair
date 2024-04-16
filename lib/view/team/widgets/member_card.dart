import 'dart:ui';

import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key,
    required this.image,
    required this.imageBackground,
    required this.name,
    required this.workDescription,
    required this.badgeText,
    required this.badgeColor,
  });
  final String image;
  final Color imageBackground;
  final String name;
  final String workDescription;
  final String badgeText;
  final Color badgeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 450,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _infoContainer(context: context),
          _imageContainer(),
        ],
      ),
    );
  }

  Container _infoContainer({required BuildContext context}) {
    return Container(
      width: 350,
      height: 350,
      decoration: _boxDecoration(),
      child: Stack(
        children: [
          _badge(context),
          Center(
            child: ListTile(
              title: Text(
                name,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                workDescription,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _badge(BuildContext context) {
    return Positioned(
      top: 280,
      left: 150,
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(-.09),
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
            color: badgeColor,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1,
              sigmaY: 2,
              tileMode: TileMode.mirror,
            ),
            child: Center(
              child: Text(
                badgeText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Positioned _imageContainer() {
    return Positioned(
      top: 10,
      child: Container(
        width: 200,
        height: 200,
        decoration: _imageDecoration(),
        child: FittedBox(
          child: Image.asset(image),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      boxShadow: _boxShadow,
    );
  }

  BoxDecoration _imageDecoration() {
    return BoxDecoration(
      color: imageBackground,
      borderRadius: BorderRadius.circular(200),
      boxShadow: _imageShadow,
    );
  }

  List<BoxShadow> get _imageShadow {
    return [
      const BoxShadow(
        color: Colors.grey,
        blurRadius: 12,
        blurStyle: BlurStyle.outer,
      ),
      BoxShadow(
        color: Colors.grey.withOpacity(1),
        blurRadius: 12,
        blurStyle: BlurStyle.solid,
      ),
    ];
  }

  List<BoxShadow> get _boxShadow {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(.6),
        blurRadius: 12,
        blurStyle: BlurStyle.outer,
      ),
      BoxShadow(
        color: Colors.grey.withOpacity(.1),
        blurRadius: 12,
        blurStyle: BlurStyle.solid,
      ),
    ];
  }
}
