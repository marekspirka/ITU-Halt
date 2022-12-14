import 'package:flutter/material.dart';

class Brno extends StatelessWidget {
  const Brno({super.key});

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
