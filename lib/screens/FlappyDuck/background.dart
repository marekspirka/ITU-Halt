/**
 * Creator Marek Spirka
 */
import 'package:flutter/material.dart';

class background extends StatelessWidget {
  const background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity, //sirka na celu stranu
        height: double.infinity, //vyska na celu stranu
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/background_flappy.png'), //odkaz na pozadie
              fit: BoxFit.cover),
        ));
  }
}
