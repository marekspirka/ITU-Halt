import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/pages/vutrdle.dart';
import 'package:flutter/material.dart';

class NavBarFlappy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 270,
      backgroundColor: Color(0xff60bcb4),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            play(context),
            sudoku(context),
            vutrdle(context),
            settings(context),
            quit(context),
          ],
        ),
      ),
    );
  }
}

play(context) {
  return Container(
      margin: const EdgeInsets.only(top: 220, right: 145),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Hrát',
            style: TextStyle(
              fontSize: 35,
            )),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        },
      ));
}

sudoku(context) {
  return Container(
      margin: const EdgeInsets.only(top: 20, right: 30),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Sudoku',
            style: TextStyle(
              fontSize: 30,
            )),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SudokuScreen()),
          );
        },
      ));
}

vutrdle(context) {
  return Container(
      margin: const EdgeInsets.only(top: 5, right: 30),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Vutrdle',
            style: TextStyle(
              fontSize: 30,
            )),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VutrdleScreen()),
          )
        },
      ));
}

settings(context) {
  return Container(
      margin: const EdgeInsets.only(top: 30, right: 50),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Nastavení',
            style: TextStyle(
              fontSize: 35,
            )),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          )
        },
      ));
}

quit(context) {
  return Container(
      margin: const EdgeInsets.only(top: 20, right: 108),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Konec',
            style: TextStyle(
              fontSize: 35,
            )),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => exit(0)),
          )
        },
      ));
}
