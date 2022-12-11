import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/pages/vutrdle.dart';
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      width: SizeConfig.screenWidth * 0.60,
      backgroundColor: Color(0xff1A0F8E).withOpacity(0.9),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            play(context),
            sudoku(context),
            vutrdle(context),
            flappyduck(context),
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
      width: SizeConfig.screenWidth * 0.60,
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.33,
          right: SizeConfig.screenWidth * 0.25),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Hrát',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10,
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
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.03,
          right: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Sudoku',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
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
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Vutrdle',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
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

flappyduck(context) {
  return Container(
      width: SizeConfig.screenWidth * 0.60,
      margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Flappy Duck',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
            )),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_scaffoldKey) => FlappyDuckScreen()),
          )
        },
      ));
}

settings(context) {
  return Container(
      width: SizeConfig.screenWidth * 0.60,
      margin: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.03,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Nastavení',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10,
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
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.14),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
        ),
        child: Text('Konec',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10,
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
