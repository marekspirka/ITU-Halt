import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tile extends StatefulWidget {
  const Tile({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Color _backgroundColor = Colors.transparent;
  late AnswerStage _answerStage;

  @override
  Widget build(BuildContext context) {
    // consumer -> will listen to other components and run builder
    // builder -> the component will rebuild when values in controller change
    // every time a letter is entered, builder rebuilds the widget and shows relevant text
    return Consumer<Controller>(builder: (_, notifier, __) {
      String text = "";
      if (widget.index < notifier.tilesEntered.length) {
        text = notifier.tilesEntered[widget.index]
            .letter; //set text to letters entered at the index passed to the widget
        _answerStage = notifier.tilesEntered[widget.index].answerStage;

        if (_answerStage == AnswerStage.correct) {
          _backgroundColor = wordleGreen;
        } else if (_answerStage == AnswerStage.contains) {
          _backgroundColor = wordleYellow;
        }

        return Container(
            decoration: BoxDecoration(
              color: _backgroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: FittedBox(
                fit: BoxFit
                    .contain, // make text as big as possible without overlapping
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )));
      } else {
        return const SizedBox();
      }
    });
  }
}
