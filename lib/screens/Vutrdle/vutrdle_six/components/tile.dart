import 'dart:math';

import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/controller_six.dart';
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

//with Single... used because we have one animation controller
class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Color _backgroundColor = wordleTileBackground;
  late AnswerStage _answerStage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _backgroundColor = wordleTileBackground;
    });
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // consumer -> will listen to other components and run builder
    // builder -> the component will rebuild when values in controller change
    // every time a letter is entered, builder rebuilds the widget and shows relevant text
    return Consumer<ControllerSix>(builder: (_, notifier, __) {
      String text = "";
      Color fontColor = Colors.white;
      if (widget.index < notifier.tilesEntered.length) {
        text = notifier.tilesEntered[widget.index]
            .letter; //set text to letters entered at the index passed to the widget
        _answerStage = notifier.tilesEntered[widget.index].answerStage;
        if (notifier.flipLine) {
          final delay = widget.index - (notifier.currentRow - 1) * 5;
          //flip the tiles in cascading form
          Future.delayed(Duration(milliseconds: 300 * delay), () {
            //animation -> start animating
            _animationController.forward();
            // reset animation permission to false, so that it does not start before pressing enter
            notifier.flipLine = false;
          });

          if (_answerStage == AnswerStage.correct) {
            _backgroundColor = wordleGreen;
          } else if (_answerStage == AnswerStage.contains) {
            _backgroundColor = wordleYellow;
          } else if (_answerStage == AnswerStage.incorrect) {
            _backgroundColor = wordleDarkGrey;
          } else {
            fontColor = Colors.black;
          }
        }

        // will rebuild the screen with every animation frame
        return AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            double flipCorrection = 0;
            if (_animationController.value > 0.50) {
              flipCorrection = pi;
            }
            return Transform(
              // animation -> will rotate around the center of the Tile
              alignment: Alignment.center,
              transform: Matrix4.identity()
                //setup the animation when ENTER is pressed -> rotate around the X axis
                ..rotateX(_animationController.value * pi)
                ..rotateX(flipCorrection),
              child: Container(
                  decoration: BoxDecoration(
                    // set background color only when the tile has flipped
                    color: flipCorrection > 0
                        ? _backgroundColor
                        : wordleTileBackground,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FittedBox(
                      fit: BoxFit
                          .contain, // make text as big as possible without overlapping
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: flipCorrection > 0
                            ? Text(
                                text,
                                style: TextStyle(
                                  color: fontColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Text(
                                text,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ))),
            );
          },
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }
    });
  }
}
