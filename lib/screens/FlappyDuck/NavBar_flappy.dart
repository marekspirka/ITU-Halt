/**
 * Creator Marek Spirka
 */
import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/controller_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/pages/vutrdle_five.dart';
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../globals.dart' as globals;

class NavBarFlappy extends StatefulWidget {
  const NavBarFlappy({Key? key}) : super(key: key);

  @override
  State<NavBarFlappy> createState() => _NavBarFlappyState();
}

class _NavBarFlappyState extends State<NavBarFlappy> {
  late Timer countdownTimer;
  Duration myDuration = const Duration(days: 5);

  @override
  Widget build(BuildContext context) {
    (globals.isTimeOff) ? startTimer() : nop();
    SizeConfig().init(context);
    //vytvorenie a graficke navrhnutie Navbaru
    return Drawer(
      width: SizeConfig.screenWidth * 0.60,
      backgroundColor: Colors.black.withOpacity(0.8),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          //odkazovanie sa na nastavenia a ine hry v Menu Bar
          children: [
            myTimer(context),
            menu(context),
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
      return const Text(
        "",
      );
    }
  }

  //Nastavenie text button, ktory sa po stlaceni dostane na hlavnu stranku vyberu hry
  //textu nastavujeme pozadovane parametre a graficke prevedenie

  play(context) {
    return Container(
      width: SizeConfig.screenWidth * 0.60,
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.18,
          right: SizeConfig.screenWidth * 0.2),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text('Hrát',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10,
            )),
        onPressed: () => {
          globals.isTimeOff = false,
          Timer(
            const Duration(seconds: 1),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MainScreen()),
              );
              globals.isTimeOff = true;
            },
          ),
        },
      ),
    );
  }

  //textu nastavujeme pozadovane parametre a graficke prevedenie
  menu(context) {
    return Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.32,
            right: SizeConfig.screenWidth * 0.20),
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

  //Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde je hra sudoku
  //textu nastavujeme pozadovane parametre a graficke prevedenie
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

  //Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde je hra vutrdle
  //textu nastavujeme pozadovane parametre a graficke prevedenie
  vutrdle(context) {
    return Container(
      margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.09),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text('Vutrdle',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 8,
            )),
        onPressed: () => {
          globals.isTimeOff = false,
          Timer(
            const Duration(seconds: 1),
            () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiProvider(providers: [
                        ChangeNotifierProvider(
                            create: (_) =>
                                ControllerFive()) //make controller accessible throughout the project
                      ], child: const VutrdleScreenFive())));
              globals.isTimeOff = true;
            },
          ),
        },
      ),
    );
  }

  //Nastavenie text button, ktory sa po stlaceni dostane na cast aplikacie kde su nastavenia aplikacie
  //textu nastavujeme pozadovane parametre a graficke prevedenie
  settings(context) {
    return Container(
      width: SizeConfig.screenWidth * 0.60,
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
          Timer(
            const Duration(seconds: 1),
            () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );

              globals.isTimeOff = true;
            },
          ),
        },
      ),
    );
  }

  //Nastavenie text button, ktory po stlaceni vypne aplikaciu
  //textu nastavujeme pozadovane parametre a graficke prevedenie
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
