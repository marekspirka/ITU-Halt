import 'package:Halt/screens/Vutrdle/components/tile.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 30, //set the number of rows
        padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Tile(
              index: index,
            ),
          );
        });
  }
}
