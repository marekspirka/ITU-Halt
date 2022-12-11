import 'package:Halt/screens/Vutrdle/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tile extends StatelessWidget {
  const Tile({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    // consumer -> will listen to other components and run builder
    // builder -> the component will rebuild when values in controller change
    // every time a letter is entered, builder rebuilds the widget and shows relevant text
    return Consumer<Controller>(builder: (_, notifier, __) {
      String text = "";
      if (index < notifier.tilesEntered.length) {
        text = notifier.tilesEntered[index]
            .letter; //set text to letters entered at the index passed to the widget
        return Center(child: Text(text));
      } else {
        return const SizedBox();
      }
    });
  }
}
