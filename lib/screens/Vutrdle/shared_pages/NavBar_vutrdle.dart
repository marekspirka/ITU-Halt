// created by Andrea Michlíková - xmichl11, Marek Špirka - xspirk01
// holds a navigation bar that lest user move through different parts of the app
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';

import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../../globals.dart' as globals;

class NavBarVutrdle extends StatefulWidget {
  const NavBarVutrdle({super.key});

  @override
  State<NavBarVutrdle> createState() => _NavBarVutrdleState();
}

class _NavBarVutrdleState extends State<NavBarVutrdle> {
  late Timer countdownTimer;
  Duration myDuration = const Duration(days: 5);

  @override
  // by Marek Špirka - xspirk01
  Widget build(BuildContext context) {
    (globals.isTimeOff) ? startTimer() : nop();
    SizeConfig().init(context);
    //vytvorenie a graficke navrhnutie Navbaru
    return Drawer(
      width: SizeConfig.screenWidth * 0.60,
      backgroundColor: Colors.black.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //odkazovanie sa na nastavenia a ine hry v Menu Bar
        children: [
          myTimer(context),
          menu(context),
          sudoku(context),
          flappyduck(context),
          settings(context),
          quit(context),
        ],
      ),
    );
  }

  // by Andrea Michlíková - xmichl11
  nop() {
    return;
  }

  // start the timer <- by Andrea Michlíková - xmichl11
  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
      // when leaving navbar stop timer
      if (!globals.isTimeOff) {
        countdownTimer.cancel();
      }
      timer.cancel();
      countdownTimer.cancel();
    });
  }

  // decrease the timer <- by Andrea Michlíková - xmichl11
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      myDuration = Duration(seconds: seconds);
    });
  }

  // set the globals variable <- by Andrea Michlíková - xmichl11
  void globalTimeSet() {
    DateTime now = DateTime.now();
    String myTime = DateFormat('mm:ss').format(now);
    globals.endTime = DateFormat('mm:ss').parse(myTime);
    globals.userTimeLeft = globals.endTime.difference(globals.startTime);
  }

  // Setting the text button, which, when pressed, will take you to the main game selection page
  // we set the required parameters and graphic design of the text
  // Andrea Michlíková - xmichl11
  myTimer(context) {
    if (globals.isGlobal && globals.isTimeOn) {
      globalTimeSet();
      String strDigits(int n) => n.toString().padLeft(2, '0');
      final minutes =
          strDigits(globals.userTime - globals.userTimeLeft.inMinutes - 1);
      final seconds = strDigits(59 - globals.userTimeLeft.inSeconds % 60);
      String time = '$minutes:$seconds';

      return Container(
        width: SizeConfig.screenWidth * 0.60,
        margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Zbývající čas:',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 7,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Text(time,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeConfig.safeBlockHorizontal * 10,
                )),
          ],
        ),
      );
    } else {
      return Container(
        width: SizeConfig.screenWidth * 0.60,
        margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.2,
        ),
      );
    }
  }

  // Nastavenie text button, ktory sa po stlaceni dostane na hlavnu stranku vyberu hry
  // textu nastavujeme pozadovane parametre a graficke prevedenie
  // Marek Špirka - xspirk01
  menu(context) {
    return Container(
      margin: EdgeInsets.only(
          right: SizeConfig.screenWidth * 0.20,
          top: SizeConfig.screenHeight * 0.05),
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
      ),
    );
  }

  // Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde je hra sudoku
  // textu nastavujeme pozadovane parametre a graficke prevedenie
  // Marek Špirka - xspirk01
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
          Timer(const Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SudokuScreen()),
            );
            globals.isTimeOff = true;
          }),
        },
      ),
    );
  }

  //Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde je hra flappyduck
  //textu nastavujeme pozadovane parametre a graficke prevedenie
  //Marek Špirka - xspirk01
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
          Timer(const Duration(seconds: 1), () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_scaffoldKey) => FlappyDuckScreen()),
            );
            globals.isTimeOff = true;
          }),
        },
      ),
    );
  }

  // Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde su nastavenia aplikacie
  // textu nastavujeme pozadovane parametre a graficke prevedenie
  // Marek Špirka - xspirk01
  settings(context) {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.03,
      ),
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
      ),
    );
  }

  // Nastavenie text button, ktory po stlaceni vypne aplikaciu
  // textu nastavujeme pozadovane parametre a graficke prevedenie
  // Marek Špirka - xspirk01
  quit(context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.16),
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
