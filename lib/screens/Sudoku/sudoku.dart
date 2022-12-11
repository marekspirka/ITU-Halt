import 'package:Halt/screens/Sudoku/components/blok_char.dart';
import 'package:Halt/screens/Sudoku/components/box_inner.dart';
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
  List<BoxInner> boxInners = [];
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
        backgroundColor: const Color(0xff270e17),
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4E1C2E),
              Color(0xffAA6728),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // sudoku pattern TODO

        //child: Container(
        //  alignment: Alignment.center,
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
                //color: Colors.blueGrey,
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.black.withOpacity(0.25),
                //height: 50,
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
                    BoxInner boxInner = boxInners[index];

                    return Container(
                      //height: 50,
                      //padding: const EdgeInsets.all(20),

                      width: double.maxFinite,
                      alignment: Alignment.center,
                      child: GridView.builder(
                        //itemCount: 9,
                        itemCount: boxInner.blokChars.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 2.5,
                          mainAxisSpacing: 2.5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        //itemBuilder: (buildContext, index) {
                        itemBuilder: (context, indexChar) {
                          //
                          BlokChar blokChar = boxInner.blokChars[indexChar];
                          //Color color = Colors.yellow.shade100;
                          Color color = const Color(0x66D9D9D9); // 66 = 40%
                          Color colorText = Colors.black;

                          // change color base condition

                          if (isFinish) {
                            color = Colors.green;
                          } else if (blokChar.isFocus && blokChar.text != "") {
                            color = const Color(0xD9F1C942); //D9 = 85%
                          } else if (blokChar.isFocus && blokChar.text == "") {
                            color = const Color(0x66F1C942); //66 = 40%
                          } else if (blokChar.isDefault) {
                            color = const Color(0xBFD9D9D9); // BF = 75%
                            //color = Colors.grey.shade400;
                          }

                          if (tapBoxIndex == "${index}-${indexChar}" &&
                              !isFinish) {
                            color = const Color(0xA6F1C942); //99 = 65%;
                          }
                          //if (this.isFinish) {
                          //  colorText = Colors.white;
                          //} else
                          if (blokChar.isExist && blokChar.text != "") {
                            if (blokChar.isDefault) {
                              color = Colors.red.withOpacity(0.85); //D9 = 85%
                            } else {
                              color = Colors.red.withOpacity(0.4); //66 = 40%
                            }
                          }
                          //
                          return Container(
                            /*decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(5),
                            ),*/
                            //color: color,
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: blokChar.isDefault
                                  ? null
                                  : () => setFocus(index, indexChar),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(color),
                                  /*padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          EdgeInsets.all(15)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),*/
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    //side:  BorderSide(color: Colors.red)
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
                // color: Colors.lightGreen,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: Colors.black.withOpacity(0.25),
                //height: 50,
                width: double.maxFinite,
                //width: 200,
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
                    /*return Container(
                      decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      //height: 50,
                      //padding: const EdgeInsets.all(20),
                      //width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    );*/
                    String text;
                    int? input;

                    if (index == 9) {
                      text = "X";
                      input = null;
                    } else {
                      text = "${index + 1}";
                      input = index + 1;
                    }

                    return ElevatedButton(
                      onPressed: () => setInput(input),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xA6D9D9D9), // A6 = 65%
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // <-- Radius
                        ),
                      ),
                      /*style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xA6D9D9D9)) // A6 = 65%
                          ),*/
                      child: Text(
                        text,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
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
                //color: Colors.orangeAccent,
                color: Colors.black.withOpacity(0.25),
                //padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                padding: const EdgeInsets.symmetric(vertical: 5),
                //padding: const EdgeInsets.all(15),
                //height: 50,
                width: double.maxFinite,
                //width: 200,
                alignment: Alignment.center,
                child: GridView.builder(
                  itemCount: 3,
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
                    /*return Container(
                      color: Colors.blueAccent,
                      //height: 50,
                      //padding: const EdgeInsets.all(20),
                      //width: double.maxFinite,
                      alignment: Alignment.center,
                      child: Text("${index + 1}"),
                    );*/

                    if (index == 0) {
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: const Icon(Icons.refresh),
                      );
                    } else if (index == 1) {
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black.withOpacity(0.5)),
                        ),

                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return ElevatedButton(
                        //onPressed: () => setInput(index + 1),
                        onPressed: () => generatePuzzle(),

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black.withOpacity(0.5)),
                        ),

                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(color: Colors.white),
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
    boxInners.clear();
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

          //if (boxInners.where((element) => element.index == index).length ==  0) {
          if (boxInners.where((element) => element.index == index).isEmpty) {
            boxInners.add(BoxInner(index, []));
          }

          BoxInner boxInner =
              boxInners.where((element) => element.index == index).first;

          boxInner.blokChars.add(BlokChar(
            entryIn.value == 0 ? "" : entryIn.value.toString(),
            index: boxInner.blokChars.length,
            isDefault: entryIn.value != 0,
            isCorrect: entryIn.value != 0,
            correctText: tempListCompletes[entryIn.key].toString(),
          ));
        });
      },
    );

    // complte generate puzzle sudoku
  }

  setFocus(int index, int indexChar) {
    tapBoxIndex = "$index-$indexChar";
    focusClass.setData(index, indexChar);
    showFocusCenterLine();
    setState(() {});
  }

  void showFocusCenterLine() {
    // set focus color for line vertical & horizontal
    int rowNoBox = focusClass.indexBox! ~/ 3;
    int colNoBox = focusClass.indexBox! % 3;

    this.boxInners.forEach((element) => element.clearFocus());

    boxInners.where((element) => element.index ~/ 3 == rowNoBox).forEach(
        (e) => e.setFocus(focusClass.indexChar!, Direction.Horizontal));

    boxInners
        .where((element) => element.index % 3 == colNoBox)
        .forEach((e) => e.setFocus(focusClass.indexChar!, Direction.Vertical));
  }

  setInput(int? number) {
    // set input data based grid
    // or clear out data
    if (focusClass.indexBox == null) return;
    if (boxInners[focusClass.indexBox!].blokChars[focusClass.indexChar!].text ==
            number.toString() ||
        number == null) {
      boxInners.forEach((element) {
        element.clearFocus();
        element.clearExist();
      });
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setEmpty();
      tapBoxIndex = null;
      isFinish = false;
      showSameInputOnSameLine();
    } else {
      boxInners[focusClass.indexBox!]
          .blokChars[focusClass.indexChar!]
          .setText("$number");

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
        boxInners[focusClass.indexBox!].blokChars[focusClass.indexChar!].text!;

    boxInners.forEach((element) => element.clearExist());

    boxInners.where((element) => element.index ~/ 3 == rowNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Horizontal));

    boxInners.where((element) => element.index % 3 == colNoBox).forEach((e) =>
        e.setExistValue(focusClass.indexChar!, focusClass.indexBox!, textInput,
            Direction.Vertical));

    List<BlokChar> exists = boxInners
        .map((element) => element.blokChars)
        .expand((element) => element)
        .where((element) => element.isExist)
        .toList();

    if (exists.length == 1) exists[0].isExist = false;
  }

  void checkFinish() {
    int totalUnfinish = boxInners
        .map((e) => e.blokChars)
        .expand((element) => element)
        .where((element) => !element.isCorrect)
        .length;

    isFinish = totalUnfinish == 0;
  }
}
