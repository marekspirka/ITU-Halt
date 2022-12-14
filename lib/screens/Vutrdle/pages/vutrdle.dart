import 'dart:math';

import 'package:Halt/scale.dart';
import 'package:Halt/screens/Vutrdle/components/helper_bar.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:Halt/screens/Vutrdle/constants/words.dart';
import 'package:Halt/screens/Vutrdle/data/keys_map.dart';
import 'package:Halt/screens/Vutrdle/pages/NavBar_vutrdle.dart';
import 'package:Halt/screens/Vutrdle/pages/Vutrdle_help.dart';
import 'package:Halt/screens/Vutrdle/components/grid.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/keyboardRow.dart';
import '../controller.dart';

class VutrdleScreen extends StatefulWidget {
  const VutrdleScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<VutrdleScreen> createState() => _VutrdleScreenState();
}

class _VutrdleScreenState extends State<VutrdleScreen> {
  late String _word;

  @override
  void initState() {
    // generate random int up to the maximum in the list of words
    final r = Random().nextInt(words.length);
    _word = words[r];
    correctWord = words[r];

    // set an instance of a build context - at the end of a frame when we DO have an instance
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // call setCorrectWord with the randomly chosen word
      Provider.of<Controller>(context, listen: false)
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
              child: Grid(),
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
