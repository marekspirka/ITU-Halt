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
    final size = MediaQuery.of(context).size;
    int index = 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keysMap.entries.map((e) {
        index++;
        print('index $index of key: ${e.key}');
        if (index >= min && index <= max) {
          return Padding(
            padding: EdgeInsets.all(size.width * 0.006),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              // rounded edges
              child: Container(
                // individual buttons
                color: Colors.red,
                width: (e.key == 'ENTER' || e.key == 'BACK')
                    ? size.width * 0.13
                    : size.width * 0.085,
                height: size.height * 0.090,
                child: Material(
                    child: InkWell(
                        onTap: () {}, child: Center(child: Text(e.key)))),
              ),
            ),
          ); // index is from 1 here
        } else {
          return const SizedBox();
        }
      }).toList(), //return a list of widgets //toList prompts it to run
    );
  }
}
