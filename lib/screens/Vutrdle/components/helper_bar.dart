import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/controller.dart';
import 'package:Halt/screens/Vutrdle/data/helper_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelperBar extends StatelessWidget {
  HelperBar({
    required this.max,
    Key? key,
  }) : super(key: key);

  final int max;
  Color currentColor = wordleLightGrey;
  Color fontColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<Controller>(builder: (_, notifier, __) {
      int index = 0;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: helperMap.entries.map((e) {
          index++;
          //print('index $index of key: ${e.key}');
          if (index <= max) {
            if (e.value == HelperStage.guessed) {
              currentColor = wordleGreen;
              fontColor = Colors.white;
            }
            return Padding(
              padding: EdgeInsets.all(size.width * 0.006),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                // rounded edges
                child: SizedBox(
                  // individual buttons
                  width: size.width * 0.085,
                  height: size.height * 0.090,
                  child: Material(
                      color: currentColor,
                      child: InkWell(
                          onTap: () {
                            // method in controller.dart
                            // provider will pull method of controller thanks to <Controller>
                            // e.key holds which key was tapped
                            // listen:false to -> we only want to read controller, not listen to it
                            Provider.of<Controller>(context, listen: false)
                                .setKeyTapped(value: e.key, context: context);
                          },
                          child: Center(
                            child: Text(
                              e.key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: fontColor,
                              ),
                            ),
                          ))),
                ),
              ),
            ); // index is from 1 here
          } else {
            return const SizedBox();
          }
        }).toList(), //return a list of widgets //toList prompts it to run
      );
    });
  }
}
