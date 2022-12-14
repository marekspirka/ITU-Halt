/**
 * Creator Marek Spirka
 */
import 'package:flutter/material.dart';

/**
 * Tato trieda sa vola vo flappyduck.dart a urcuje mu vzhlad Barier
 */
class MyBarrier extends StatelessWidget {
  final size;

  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: size,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage('assets/images/barriers.png'), //odkaz na barerru
              fit: BoxFit.cover),
        ));
  }
}
