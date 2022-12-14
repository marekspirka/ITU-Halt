// created by Andrea Michlíková - xmichl11

import 'package:Halt/scale.dart';
import 'package:Halt/screens/Sudoku/constants/sudoku_colors.dart';
import 'package:Halt/screens/Sudoku/components/blok_item.dart';
import 'package:Halt/screens/Sudoku/components/inner_blok.dart';
import 'package:Halt/screens/Sudoku/components/class.dart';
import 'package:Halt/screens/Sudoku/NavBar_sudoku.dart';
import 'package:Halt/screens/Sudoku/Sudoku_help.dart';

import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'dart:math';

import '../../globals.dart' as globals;

import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({Key? key}) : super(key: key);

  @override
  State<SudokuScreen> createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  double safeBlockHorizontal = SizeConfig.safeBlockHorizontal;
  double safeBlockVertical = SizeConfig.safeBlockVertical;

  bool mute = false;

  List<InnerBlok> innerBloks = [];
  List<InputClass> inputClassBlok = [];
  List<int> inputNumber = [];

  SettingsClass settings = SettingsClass();
  FocusClass focusClass = FocusClass();
  String? tapBoxIndex;
  String difficulty = 'Lehké';
  Color difficultyColorEasy = sudokuYellow85;
  Color difficultyColorMedium = sudokuWhite45;
  Color difficultyColorHard = sudokuWhite45;
  bool isFinish = false;
  bool smallNumber = false;

  @override
  void initState() {
    generateSudoku();
    focusClass.inputNumber = 0;

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
    (globals.isTimeOn) ? globals.isTimeOff = true : globals.isTimeOff = false;
    return Scaffold(
      drawer: const NavBarSudoku(),
      endDrawer: NavBarSudokuHelp(),
      appBar: AppBar(
        actions: [
          Builder(
              builder: (context) => IconButton(
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
        child: Column(
          children: [
            // vrchní část
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                //heightFactor: safeBlockVertical * 0.2,
                //widthFactor: safeBlockHorizontal * 0.2,
                child: Text(
                  difficulty,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),

            // prostřední část
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
                          BlokItem itemBlok = innerBlok.blokItem[indexChar];
                          Color color = sudokuWhite45;

                          bool isDefault = itemBlok.isDefault;

                          // change color base condition
                          if (isFinish) {
                            color = Colors.green;
                            // highlight lines or same numbers
                          } else if (itemBlok.isFocusCross ||
                              itemBlok.isFocusNumber) {
                            color = isDefault ? sudokuYellow85 : sudokuYellow65;
                            // default numbers
                          } else if (isDefault) {
                            color = sudokuWhite75;
                          }

                          // box with we working
                          if (tapBoxIndex == "$index-$indexChar" &&
                              !isDefault &&
                              itemBlok.isFocus) {
                            color = sudokuYellow65;
                          }

                          // fault
                          if (itemBlok.isExist && itemBlok.text != "") {
                            color = isDefault ? sudokuRed85 : sudokuRed40;
                          }

                          if (smallNumber && itemBlok.smallNumber) {
                            return Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () => setFocus(index, indexChar,
                                    "${itemBlok.text}", isDefault),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(color),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ))),
                                child: Text(
                                  "${itemBlok.text}",
                                  style: TextStyle(
                                      color: sudokuBlack,
                                      fontSize: safeBlockHorizontal * 3),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () => setFocus(index, indexChar,
                                    "${itemBlok.text}", isDefault),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(color),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ))),
                                child: Text(
                                  "${itemBlok.text}",
                                  style: TextStyle(
                                      color: sudokuBlack,
                                      fontSize: safeBlockHorizontal * 5),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),

            // spodní část
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
                    InputClass inputClass = inputClassBlok[index];
                    String myIndex;
                    String smallIndex;
                    int? input;

                    if (index == 9) {
                      myIndex = "X";
                      smallIndex = "";
                      input = null;
                    } else {
                      myIndex = "${inputClass.index + 1}";
                      smallIndex = "${inputClass.numberInput}";
                      input = inputClass.index + 1;
                    }

                    return ElevatedButton(
                      onPressed: () {
                        setInputFocus(index, input, myIndex);
                        unsetInputFocus(index);
                        setState(() => inputClass.isInputFocus =
                            (focusClass.indexBox == null)
                                ? !inputClass.isInputFocus
                                : inputClass.isInputFocus);
                        setState(() => inputClass.isInputAll =
                            (inputClass.numberInput == 0) ? true : false);
                        //inputClassBlok[number - 1].numberInput++;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: inputClass.isInputAll
                            ? sudokuWhite45
                            : inputClass.isInputFocus
                                ? sudokuYellow85
                                : sudokuWhite65,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            myIndex,
                            style: TextStyle(
                                color: sudokuBlack,
                                fontSize: safeBlockHorizontal * 6.5),
                          ),
                          Text(
                            smallIndex,
                            style: TextStyle(
                                color: sudokuBlack,
                                fontSize: safeBlockHorizontal * 4),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // nejspodnější část
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
                      // nastavení
                      return ElevatedButton(
                        onPressed: () => sudokuSettings(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sudokuBlack50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Icon(Icons.settings_rounded),
                      );
                    } else if (index == 1) {
                      // nová hra
                      return ElevatedButton(
                        onPressed: () => generateSudoku(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sudokuBlack50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Icon(Icons.autorenew_rounded),
                      );
                    } else if (index == 2) {
                      // tužka na malé čísla
                      return ElevatedButton(
                        onPressed: () {
                          setState(() => smallNumber = !smallNumber);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              smallNumber ? sudokuBlack75 : sudokuBlack50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Icon(Icons.create_rounded),
                      );
                    } else {
                      // zpátky
                      return ElevatedButton(
                        onPressed: () {
                          setState(() => clearNotDefault());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sudokuBlack50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
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
    innerBloks.clear();
    inputClassBlok.clear();

    for (int i = 0; i < 9; i++) {
      inputClassBlok.add(InputClass(i, 9, false, false));
    }
    inputClassBlok.add(InputClass(9, -1, false, false));

    var sudokuGenerator = SudokuGenerator(
        emptySquares:
            globals.sudokuDifficulty); //počet volných polí = obtížnost

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

          if (entryIn.value != 0) {
            inputClassBlok[entryIn.value - 1].numberInput--;
            if (inputClassBlok[entryIn.value - 1].numberInput == 0) {
              inputClassBlok[entryIn.value - 1].isInputAll = true;
            }
          }
        });
      },
    );
  }

  setFocus(int index, int indexChar, String textString, bool defaultNumber) {
    tapBoxIndex = "$index-$indexChar";
    BlokItem item = innerBloks[index].blokItem[indexChar];

    if (focusClass.inputNumber != 0) {
      focusClass.setData(index, indexChar, textString);
      setInput(focusClass.inputNumber);
      if (item.text == "") {
        item.isFocusNumber = false;
      } else {
        item.isFocusNumber = item.isFocusNumber ? false : true;
      }
      focusClass.setData(null, null, null);
      setState(() {});
      return;
    }

    // unset hightlight/focus
    if (item.isFocusCross || item.isFocusNumber) {
      item.isFocus = false;
      focusClass.setData(null, null, null);
      unsetFocus();
    } else {
      // set hightlight/focus
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

  clearNotDefault() {
    for (var element in innerBloks) {
      element.clearNotDefault();
      element.clearFocus();
      element.clearExist();
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

    if (focusClass.indexBox != null) {
      innerBloks.where((element) => element.index == element.index).forEach(
          (e) => e.setFocus(textString, focusClass.indexChar!, Direction.all));
    } else {
      innerBloks
          .where((element) => element.index == element.index)
          .forEach((e) => e.setFocus(textString, 0, Direction.all));
    }
  }

  setInputFocus(int index, int? number, String myIndex) {
    // set highlight to input box
    if (focusClass.indexBox == null) {
      InputClass item = inputClassBlok[index];
      if (!item.isInputFocus) {
        showFocusNumber(myIndex);
        focusClass.inputNumber = number;
      } else {
        unsetFocus();
        focusClass.inputNumber = 0;
      }
      return;
    }

    setInput(number);
  }

  unsetInputFocus(int index) {
    for (var element in inputClassBlok) {
      if (element.index != index) {
        element.isInputFocus = false;
      }
    }
  }

  setInput(int? number) {
    BlokItem item =
        innerBloks[focusClass.indexBox!].blokItem[focusClass.indexChar!];
    // box is default
    if (item.isDefault) {
      return;
    }

    // set input data or clear data
    if (item.text == number.toString() || number == null) {
      for (var element in innerBloks) {
        element.clearExist();
      }
      item.setEmpty();
      if (number != null) {
        inputClassBlok[number - 1].numberInput++;
      }
      //tapBoxIndex = null;
      isFinish = false;
      showSameInputOnSameLine();
    } else {
      // set input data to empty box
      inputClassBlok[number - 1].numberInput--;
      item.setText("$number");
      showSameInputOnSameLine();

      checkFinish();
    }

    setState(() {});
  }

  // show duplicate number on same line vertical & horizontal
  void showSameInputOnSameLine() {
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
    //if (exists.length == 1) exists[0].isWrong = false;
  }

// sudoku is complete
  void checkFinish() {
    int totalUnfinish = innerBloks
        .map((e) => e.blokItem)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;

    isFinish = totalUnfinish == 0;
  }

  void sudokuSettings() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          SizeConfig().init(context);
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
                horizontal: safeBlockHorizontal * 5,
                vertical: safeBlockVertical * 30),
            backgroundColor: sudokuBlack75,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'OBTÍŽNOST',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        height: 3,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => {
                              difficulty = "Lehké",
                              globals.sudokuDifficulty = 36,
                              difficultyColorEasy = sudokuYellow85,
                              difficultyColorMedium = sudokuWhite45,
                              difficultyColorHard = sudokuWhite45,
                            });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: difficultyColorEasy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lehké",
                            style: TextStyle(
                                color: sudokuBlack,
                                fontSize: safeBlockHorizontal * 6.5),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => {
                              difficulty = "Střední",
                              globals.sudokuDifficulty = 47,
                              difficultyColorEasy = sudokuWhite45,
                              difficultyColorMedium = sudokuYellow85,
                              difficultyColorHard = sudokuWhite45,
                            });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: difficultyColorMedium,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Střední",
                            style: TextStyle(
                                color: sudokuBlack,
                                fontSize: safeBlockHorizontal * 6.5),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => {
                              difficulty = "Těžké",
                              globals.sudokuDifficulty = 54,
                              difficultyColorEasy = sudokuWhite45,
                              difficultyColorMedium = sudokuWhite45,
                              difficultyColorHard = sudokuYellow85,
                            });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: difficultyColorHard,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Těžké",
                            style: TextStyle(
                                color: sudokuBlack,
                                fontSize: safeBlockHorizontal * 6.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        });
  } // showDialogF()
} // class _SudokuScreenState
