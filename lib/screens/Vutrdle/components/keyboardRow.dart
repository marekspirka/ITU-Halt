import 'package:flutter/material.dart';
import '../data/keys_map.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    required this.min,
    required this.max,
    Key? key,
  }) : super(key: key);

  final int min, max;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Row(
      children: keysMap.entries.map((e) {
        index++;
        print('index $index of key: ${e.key}');
        if (index >= min && index <= max) {
          return Text(e.key); // index is from 1 here
        } else {
          return const SizedBox();
        }
      }).toList(), //return a list of widgets //tolist prompts it to run
    );
  }
}
