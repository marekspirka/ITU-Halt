import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

class Brno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_flappy.png'),
              fit: BoxFit.cover),
        ));
  }
}
