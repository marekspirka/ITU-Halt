//created by Kateřina Lojdová - xlojdo00
// holds the main page for a 5-letter game
import 'dart:math';

import 'package:Halt/scale.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/constants/words_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/components/grid_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/components/helper_bar.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/controller_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/shared_pages/NavBar_vutrdle.dart';
import 'package:Halt/screens/Vutrdle/shared_pages/Vutrdle_help.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/keyboardRow.dart';

class VutrdleScreenFive extends StatefulWidget {
  const VutrdleScreenFive({
    Key? key,
  }) : super(key: key);

  @override
  State<VutrdleScreenFive> createState() => _VutrdleScreenFiveState();
}

class _VutrdleScreenFiveState extends State<VutrdleScreenFive> {
  late String _word;

  @override
  void initState() {
    // generate random int up to the maximum in the list of words
    final r = Random().nextInt(wordsFive.length);
    // set the correct word that we would be guessing
    _word = wordsFive[r];
    correctWord = wordsFive[r];

    // set an instance of a build context - at the end of a frame when we DO have an instance
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // call setCorrectWord with the randomly chosen word
      Provider.of<ControllerFive>(context, listen: false)
          .setCorrectWord(word: _word);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: const NavBarVutrdle(),
      endDrawer: const NavBarVutrdleHelp(),
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
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [backgroundPurple, backgroundPink])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              flex: 7,
              child: GridFive(),
            ),
            const Expanded(
                child: HelperBar(
              max: 5,
            )),
            Expanded(
              flex: 4,
              child: Column(
                children: const [
                  KeyboardRow(min: 1, max: 10),
                  KeyboardRow(min: 11, max: 19),
                  KeyboardRow(min: 20, max: 29),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
