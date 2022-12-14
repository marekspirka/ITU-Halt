import 'dart:io';

import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/Vutrdle/constants/answer_stages.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/stats.dart';
import 'package:flutter/material.dart';

class StatsBoxLost extends StatelessWidget {
  const StatsBoxLost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.15,
          size.width * 0.1, size.height * 0.15),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear)),
          const Expanded(
              child: Text(
            'TENTOKRÁT TO NEVYŠLO :(',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Expanded(
              child: Text(
                'Hledané slovo bylo:    $correctWord',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: const Text('v řadě'),
              )
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: const Text('Nejvyšší skóre: '),
              ),
              Container(
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
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: const Text(
                  'ZBÝVAJÍCÍ ČAS:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: wordleYellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const FittedBox(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('5',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
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
                child: const Text('Hádej další')),
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
                child: const Text('Konec')),
          )),
        ],
      ),
    );
  }
}
