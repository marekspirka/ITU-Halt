import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:flutter/material.dart';

class StatsBox extends StatelessWidget {
  const StatsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IconButton(
              alignment: Alignment.centerRight,
              onPressed: () {},
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
                    child: Text('5',
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
                  //Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                },
                child: Text('Hádej další')),
          )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: wordleDarkGrey,
                ),
                onPressed: () {},
                child: Text('Konec')),
          )),
        ],
      ),
    );
  }
}
