import 'package:Halt/screens/Vutrdle/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/pages/NavBar_vutrdle.dart';
import 'package:Halt/screens/Vutrdle/pages/Vutrdle_help.dart';
import 'package:Halt/screens/Vutrdle/components/grid.dart';

import 'package:flutter/material.dart';

import '../components/keyboardRow.dart';

class VutrdleScreen extends StatelessWidget {
  const VutrdleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBarVutrdle(),
      endDrawer: NavBarVutrdleHelp(),
      appBar: AppBar(
        actions: [
          Builder(
              builder: (context) => // Ensure Scaffold is in context
                  IconButton(
                      icon: const Icon(Icons.question_mark_outlined),
                      onPressed: () => Scaffold.of(context).openEndDrawer())),
        ],
        title: const Text('Halt.'),
        titleTextStyle: const TextStyle(fontSize: 35),
        centerTitle: true,
        backgroundColor: const Color(0xff210a64),
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.yellow,
              child: const Grid(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.green,
              child: Column(
                children: [
                  KeyboardRow(min: 1, max: 10),
                  KeyboardRow(min: 11, max: 19),
                  KeyboardRow(min: 20, max: 29),
                ],
              ),
            ),
          ),
        ],
      ),
      // Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: [
      //         Color(0xff3c12b4),
      //         Color(0xff941397),
      //       ],
      //       begin: Alignment.topCenter,
      //       end: Alignment.bottomCenter,
      //     ),
      //   ),
      // )
    );
  }
}
