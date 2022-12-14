/**
 * Creator Marek Spirka
 */
import 'package:flutter/material.dart';

/**
 * Tato trieda sa vola vo flappyduck.dart a urcuje mu vzhlad Barier
 */
class MyBarrier_upsidedown extends StatelessWidget {
  final size;

  MyBarrier_upsidedown({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: size,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/barriers_upsidedown.png'), //odkaz na barieru otocenu naopak aby sla z hornej castu aplikacie
              fit: BoxFit.cover),
        ));
  }
}
