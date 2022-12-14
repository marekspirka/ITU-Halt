import 'package:Halt/screens/Vutrdle/vutrdle_six/components/tile.dart';
import 'package:flutter/material.dart';

class GridSix extends StatelessWidget {
  const GridSix({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 36, //set the number of rows
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 6,
        ),
        itemBuilder: (context, index) {
          return Tile(
            index: index,
          );
        });
  }
}
