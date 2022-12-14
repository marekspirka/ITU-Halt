//created by Marek Špirka - xspirk01
// holds a navigation bar that lest user move through different parts of the app
import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import '../../../globals.dart' as globals;

import '../vutrdle_five/controller_five.dart';
import '../vutrdle_five/pages/vutrdle_five.dart';

class NavBarVutrdle extends StatefulWidget {
  const NavBarVutrdle({super.key});

  @override
  State<NavBarVutrdle> createState() => _NavBarVutrdleState();
}

class _NavBarVutrdleState extends State<NavBarVutrdle> {
  late Timer countdownTimer;
  Duration myDuration = const Duration(days: 5);

  @override
  Widget build(BuildContext context) {
    (globals.isTimeOff) ? startTimer() : nop();
    SizeConfig().init(context);
    return Drawer(
      width: SizeConfig.screenWidth * 0.60,
      backgroundColor: navbarPurple,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            myTimer(context),
            menu(context),
            sudoku(context),
            flappyduck(context),
            settings(context),
            quit(context),
          ],
        ),
      ),
    );
  }

  nop() {
    return;
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
      if (!globals.isTimeOff) {
        countdownTimer.cancel();
      }
      timer.cancel();
      countdownTimer.cancel();
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      myDuration = Duration(seconds: seconds);
    });
  }

  void globalTimeSet() {
    DateTime now = DateTime.now();
    String myTime = DateFormat('mm:ss').format(now);
    globals.endTime = DateFormat('mm:ss').parse(myTime);
    globals.userTimeLeft = globals.endTime.difference(globals.startTime);
  }

  myTimer(context) {
    if (globals.isGlobal && globals.isTimeOn) {
      globalTimeSet();
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final minutes =
          strDigits(globals.userTime - globals.userTimeLeft.inMinutes);
      final seconds = strDigits(59 - globals.userTimeLeft.inSeconds % 60);
      String time = '$minutes:$seconds';

      return Container(
          width: SizeConfig.screenWidth * 0.60,
          margin: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.18,
              bottom: SizeConfig.screenWidth * 0.0),
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Text(time,
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 10,
                )),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
            },
          ));
    } else {
      return Container(
        width: SizeConfig.screenWidth * 0.60,
        margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.2,
        ),
      );
    }
  }

  menu(context) {
    return Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.12,
            right: SizeConfig.screenWidth * 0.17),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text('Menu',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10,
              )),
          onPressed: () => {
            globals.isTimeOff = false,
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
              globals.isTimeOff = true;
            }),
          },
        ));
  }

  sudoku(context) {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.02,
          right: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text('Sudoku',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
            )),
        onPressed: () => {
          globals.isTimeOff = false,
          Timer(
            const Duration(seconds: 1),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SudokuScreen()),
              );
              globals.isTimeOff = true;
            },
          ),
        },
      ),
    );
  }

  flappyduck(context) {
    return Container(
      width: SizeConfig.screenWidth * 0.60,
      margin: EdgeInsets.only(left: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text('Flappy Duck',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
            )),
        onPressed: () => {
          globals.isTimeOff = false,
          Timer(
            const Duration(seconds: 1),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_scaffoldKey) => FlappyDuckScreen()),
              );
              globals.isTimeOff = true;
            },
          ),
        },
      ),
    );
  }

  settings(context) {
    return Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.03,
            left: SizeConfig.screenWidth * 0.02),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text('Nastavení',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10,
              )),
          onPressed: () => {
            globals.isTimeOff = false,
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
              globals.isTimeOff = true;
            }),
          },
        ));
  }

  quit(context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.15),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
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
      ),
    );
  }
}
