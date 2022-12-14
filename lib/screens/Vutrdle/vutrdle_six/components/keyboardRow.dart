//created by Kateřina Lojdová - xlojdo00
// holds the keyboard row for a 6-letter game
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/controller_six.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    // get size context for future scaling
    final size = MediaQuery.of(context).size;
    return Consumer<ControllerSix>(builder: (_, notifier, __) {
      int index = 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keysMap.entries.map((e) {
          index++;
          //print only the relevant letters
          if (index >= min && index <= max) {
            Color currentColor = wordleLightGrey;
            Color fontColor = Colors.white;
            if (e.value == AnswerStage.correct) {
              currentColor = wordleGreen;
            } else if (e.value == AnswerStage.contains) {
              currentColor = wordleYellow;
            } else if (e.value == AnswerStage.incorrect) {
              currentColor = wordleDarkGrey;
            } else {
              fontColor = Colors.black;
            }
            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                // rounded edges
                child: SizedBox(
                  // individual buttons
                  width: (e.key == 'ENTER' || e.key == 'BACK')
                      ? size.width * 0.13
                      : size.width * 0.085,
                  height: size.height * 0.080,
                  child: Material(
                      color: currentColor,
                      child: InkWell(
                          onTap: () {
                            // method in controller.dart
                            // provider will pull method of controller thanks to <Controller>
                            // e.key holds which key was tapped
                            // listen:false to -> we only want to read controller, not listen to it
                            Provider.of<ControllerSix>(context, listen: false)
                                .setKeyTapped(value: e.key, context: context);
                          },
                          child: Center(
                            child: e.key == 'BACK'
                                ? const Icon(Icons.backspace_outlined)
                                : Text(
                                    e.key,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: fontColor,
                                    ),
                                  ),
                          ))),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }).toList(), //return a list of widgets //toList prompts it to run
      );
    });
  }
}
