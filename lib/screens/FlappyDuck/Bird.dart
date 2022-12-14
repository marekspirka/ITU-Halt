/**
 * Creator Marek Spirka
 */
import 'package:flutter/material.dart';

/**
 * Tato trieda sa vola vo flappyduck.dart a urcuje vzhlad kachny
 */
class Bird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      child: Image.asset('assets/icons/Bird.png'), //odkaz na vzhlad kachny
    );
  }
}
