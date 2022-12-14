//created by Kateřina Lojdová - xlojdo00
// holds the grid for a 5-letter game
import 'package:Halt/screens/Vutrdle/vutrdle_five/components/tile.dart';
import 'package:flutter/material.dart';

class GridFive extends StatelessWidget {
  const GridFive({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // how many elements we want to show
        itemCount: 30, //set the number of rows
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        physics: const NeverScrollableScrollPhysics(),
        // grid elements spacing
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 5,
        ),
        // item of the grid is tile
        itemBuilder: (context, index) {
          return Tile(
            index: index,
          );
        });
  }
}
