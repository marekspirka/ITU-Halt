import 'package:flutter/material.dart';

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
              image: AssetImage('assets/images/barriers.png'),
              fit: BoxFit.cover),
        ));
  }
}
