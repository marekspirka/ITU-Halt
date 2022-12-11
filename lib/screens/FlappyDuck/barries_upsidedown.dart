import 'package:flutter/material.dart';

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
              image: AssetImage('assets/images/barriers_upsidedown.png'),
              fit: BoxFit.cover),
        ));
  }
}
