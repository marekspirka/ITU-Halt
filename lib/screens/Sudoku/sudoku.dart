import 'package:Halt/screens/Sudoku/NavBar_sudoku.dart';
import 'package:Halt/screens/Sudoku/Sudoku_help.dart';
import 'package:flutter/material.dart';

class SudokuScreen extends StatelessWidget {
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
                        icon: Icon(Icons.question_mark_outlined),
                        onPressed: () => Scaffold.of(context).openEndDrawer())),
          ],
          title: new Text('Halt.'),
          titleTextStyle: TextStyle(fontSize: 35),
          centerTitle: true,
          backgroundColor: Color(0xff270e17),
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
        ));
  }
}
