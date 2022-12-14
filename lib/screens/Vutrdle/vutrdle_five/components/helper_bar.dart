//created by Kateřina Lojdová - xlojdo00
// holds the helper bar for a 5-letter game
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/controller_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/data/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelperBar extends StatelessWidget {
  const HelperBar({
    required this.max,
    Key? key,
  }) : super(key: key);

  final int max;

  @override
  Widget build(BuildContext context) {
    //context for further sizing
    final size = MediaQuery.of(context).size;
    return Consumer<ControllerFive>(builder: (_, notifier, __) {
      // index of a given letter
      int index = 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: helperMap.entries.map((e) {
          index++;
          Color currentColor = wordleLightGrey;
          // we dont want to show the guessed word -> hide by making it transparent
          Color fontColor = Colors.transparent;
          if (index <= max) {
            // set tile as guessed -> show contents
            if (e.value == HelperStage.guessed) {
              currentColor = wordleGreen;
              fontColor = Colors.white;
            }
            return Padding(
              padding: EdgeInsets.all(size.width * 0.008),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                // rounded edges
                child: SizedBox(
                  // individual buttons
                  width: size.width * 0.085,
                  height: size.height * 0.055,
                  child: Material(
                      color: currentColor,
                      child: Center(
                        child: Text(
                          // text of the button - key from map
                          e.key,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: fontColor,
                          ),
                        ),
                      )),
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
