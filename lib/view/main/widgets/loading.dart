import 'dart:ui';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 5),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .1),
          child: LinearProgressIndicator(
            color: Colors.teal[100]!,
            minHeight: 15,
            borderRadius: BorderRadius.circular(200),
          ),
        ),
      ),
    );
  }
}