import 'dart:io';

import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/data/stats.dart';
import 'package:Halt/screens/Vutrdle/pages/vutrdle.dart';
import 'package:Halt/screens/Vutrdle/controller.dart';
import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.15,
          size.width * 0.1, size.height * 0.15),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear)),
          const Expanded(
              child: Text(
            'GRATULACE!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: wordleYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${results['currentStreak']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              )),
              Container(
                child: Text('v řadě'),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              )
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text('Nejvyšší skóre: '),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
              Container(
                  child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: wordleYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${results['maxStreak']}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              )),
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'ZBÝVAJÍCÍ ČAS:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
              Container(
                  child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: wordleYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('5',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              )),
            ],
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: wordleGreen,
                ),
                onPressed: () {
                  //reset key colors
                  keysMap.updateAll(
                      (key, value) => value = AnswerStage.notAnswered);
                  //reset game history
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                      (route) => false);
                },
                child: Text('Hádej další')),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () => {
                      Navigator.pop(context),
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => exit(0)),
                      )
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: wordleDarkGrey,
                ),
                child: Text('Konec')),
          )),
        ],
      ),
    );
  }
}
