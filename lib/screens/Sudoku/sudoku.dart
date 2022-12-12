import '../../scale.dart';
import 'package:Halt/screens/Sudoku/constants/sudoku_colors.dart';
import 'package:Halt/screens/Sudoku/components/blok_item.dart';
import 'package:Halt/screens/Sudoku/components/inner_blok.dart';
import 'package:Halt/screens/Sudoku/components/focus_class.dart';
import 'package:Halt/screens/Sudoku/NavBar_sudoku.dart';
import 'package:Halt/screens/Sudoku/Sudoku_help.dart';
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';

import 'dart:math';

import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({Key? key}) : super(key: key);

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  // TODO naše proměnné
  List<InnerBlok> innerBloks = [];
  FocusClass focusClass = FocusClass();
  bool isFinish = false;
  String? tapBoxIndex;

  @override
  void initState() {
    generateSudoku();
    // TODO: implement initState
    super.initState();
  }

  void generateSudoku() {
    isFinish = false;
    focusClass = FocusClass();
    tapBoxIndex = null;
    generatePuzzle();
    checkFinish();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      drawer: NavBarSudoku(),
      endDrawer: NavBarSudokuHelp(),
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
        backgroundColor: navBarBrown,
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundBrown,
              backgroundOrange,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        // TODO sudoku pattern
        child: Column(
          children: [
            // TODO vrchní část
            Expanded(
              //flex: 1,
              child: Container(
                //height: 50,
                color: Colors.lightBlueAccent,
              ),
            ),

            // TODO prostřední část
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 9,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0,
                  ),
                  itemBuilder: (context, index) {
                    InnerBlok innerBlok = innerBloks[index];

                    return Container(
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        //itemCount: 9,
                        itemCount: innerBlok.blokItem.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2.5,
                          mainAxisSpacing: 2.5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexChar) {
                          BlokItem blokChar = innerBlok.blokItem[indexChar];
                          Color color = sudokuWhite40;
                          Color colorText = Colors.black;
                          bool isDefault = blokChar.isDefault;

                          // change color base condition
                          if (isFinish) {
                            color = Colors.green;
                            // highlight lines or same numbers
                          } else if (blokChar.isFocusCross ||
                              blokChar.isFocusNumber) {
                            color = isDefault ? sudokuYellow85 : sudokuYellow40;
                            // default numbers
                          } else if (isDefault) {
                            color = sudokuWhite75;
                          }

                          // box with we working
                          if (tapBoxIndex == "$index-$indexChar" &&
                              !isDefault &&
                              blokChar.isFocus) {
                            color = sudokuYellow65;
                          }

                          // fault
                          if (blokChar.isExist && blokChar.text != "") {
                            color = isDefault ? sudokuRed85 : sudokuRed40;
                          }

                          return Container(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () => setFocus(index, indexChar,
                                  "${blokChar.text}", isDefault),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(color),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ))),
                              child: Text(
                                "${blokChar.text}",
                                style:
                                    TextStyle(color: colorText, fontSize: 20),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // TODO spodní část
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    String myIndex;
                    String smallIndex;
                    int? input;

                    if (index == 9) {
                      myIndex = "X";
                      smallIndex = "";
                      input = null;
                    } else {
                      myIndex = "${index + 1}";
                      smallIndex = "$index";
                      input = index + 1;
                    }

                    return ElevatedButton(
                      onPressed: () => setInput(input),

                      //onPressed: blokChar.isDefault ? null : () => setFocus(index, indexChar, false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: sudokuWhite65,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // <-- Radius
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            myIndex,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            smallIndex,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // TODO nejspodnější část
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                width: double.maxFinite,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // TODO nastavení
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(sudokuBlack50),
                        ),
                        child: const Icon(Icons.settings_rounded),
                      );
                    } else if (index == 1) {
                      // TODO nová hra -> od začátku by bylo lepší
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            sudokuBlack50,
                          ),
                        ),
                        child: const Icon(Icons.autorenew_rounded),
                      );
                    } else if (index == 2) {
                      // TODO tužka na malé čísla
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(sudokuBlack50),
                        ),

                        child: const Icon(Icons.create_rounded),
                      );
                    } else {
                      // TODO zpátky
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(sudokuBlack50),
                        ),

                        child: const Icon(
                          Icons.arrow_back_rounded,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  generatePuzzle() {
    // install plugins sudoku generator to generate one
    innerBloks.clear();
    var sudokuGenerator =
        SudokuGenerator(emptySquares: 36); //TODO počet volných polí = obtížnost
    // then we populate to get a possible combination
    // Quiver for easy populate collection using partition
    List<List<List<int>>> completes = partition(sudokuGenerator.newSudokuSolved,
            sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList();
    partition(sudokuGenerator.newSudoku,
            sqrt(sudokuGenerator.newSudoku.length).toInt())
        .toList()
        .asMap()
        .entries
        .forEach(
      (entry) {
        List<int> tempListCompletes =
            completes[entry.key].expand((element) => element).toList();
        List<int> tempList = entry.value.expand((element) => element).toList();

        tempList.asMap().entries.forEach((entryIn) {
          int index =
              entry.key * sqrt(sudokuGenerator.newSudoku.length).toInt() +
                  (entryIn.key % 9).toInt() ~/ 3;

          if (innerBloks.where((element) => element.index == index).isEmpty) {
            innerBloks.add(InnerBlok(index, []));
          }

          InnerBlok innerBlok =
              innerBloks.where((element) => element.index == index).first;

          innerBlok.blokItem.add(BlokItem(
            entryIn.value == 0 ? "" : entryIn.value.toString(),
            index: innerBlok.blokItem.length,
            isDefault: entryIn.value != 0,
            isCorrect: entryIn.value != 0,
            correctText: tempListCompletes[entryIn.key].toString(),
          ));
        });
      },
    );
    // complete generate puzzle sudoku
  }

  setFocus(int index, int indexChar, String textString, bool defaultNumber) {
    tapBoxIndex = "$index-$indexChar";
    BlokItem item = innerBloks[index].blokItem[indexChar];
    if (item.isFocusCross || item.isFocusNumber) {
      item.isFocus = false;
      focusClass.setData(null, null, null);
      unsetFocus();
    } else {
      item.isFocus = true;
      focusClass.setData(index, indexChar, textString);
      if (defaultNumber) {
        showFocusNumber(textString);
      } else {
        showFocusCross();
      }
    }
    setState(() {});
  }

  unsetFocus() {
    for (var element in innerBloks) {
      element.clearFocus();
    }
  }

  void showFocusCross() {
    // set focus color for line vertical & horizontal
    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    for (var element in innerBloks) {
      element.clearFocus();
    }

    innerBloks.where((element) => element.index ~/ 3 == rowNoBox).forEach(
        (e) => e.setFocus("", focusClass.indexChar!, Direction.horizontal));

    innerBloks.where((element) => element.index % 3 == colNoBox).forEach(
        (e) => e.setFocus("", focusClass.indexChar!, Direction.vertical));
  }

  void showFocusNumber(String textString) {
    // set focus color for same numbers

    for (var element in innerBloks) {
      element.clearFocus();
    }

    innerBloks.where((element) => element.index == element.index).forEach(
        (e) => e.setFocus(textString, focusClass.indexChar!, Direction.all));
  }

  setInput(int? number) {
    // box is default
    if (focusClass.indexBox == null ||
        innerBloks[focusClass.indexBox!]
            .blokItem[focusClass.indexChar!]
            .isDefault) {
      return;
    }
    BlokItem item =
        innerBloks[focusClass.indexBox!].blokItem[focusClass.indexChar!];
    // set input data or clear data
    if (item.text == number.toString() || number == null) {
      for (var element in innerBloks) {
        element.clearExist();
      }
      item.setEmpty();
      //tapBoxIndex = null;
      isFinish = false;
      showSameInputOnSameLine();
      // set input data to empty box
    } else {
      item.setText("$number");
      showSameInputOnSameLine();

      checkFinish();
    }

    setState(() {});
  }

  void showSameInputOnSameLine() {
    // show duplicate number on same line vertical & horizontal so player know he or she put a wrong value on somewhere

    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    String textInput =
        innerBloks[focusClass.indexBox!].blokItem[focusClass.indexChar!].text!;

    for (var element in innerBloks) {
      element.clearExist();
    }

    innerBloks.where((element) => element.index ~/ 3 == rowNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.horizontal));

    innerBloks.where((element) => element.index % 3 == colNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.vertical));

    List<BlokItem> exists = innerBloks
        .map((element) => element.blokItem)
        .expand((element) => element)
        .where((element) => element.isExist)
        .toList();

    if (exists.length == 1) exists[0].isExist = false;
  }

  void checkFinish() {
    int totalUnfinish = innerBloks
        .map((e) => e.blokItem)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;

    isFinish = totalUnfinish == 0;
  }
}
