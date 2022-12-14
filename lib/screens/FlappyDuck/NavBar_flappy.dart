/**
 * Creator Marek Spirka
 */
import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/controller_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/pages/vutrdle_five.dart';
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';
import 'package:provider/provider.dart';

class NavBarFlappy extends StatelessWidget {
  const NavBarFlappy({super.key});

  @override
  Widget build(BuildContext context) {
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

//Nastavenie text button, ktory sa po stlaceni dostane na hlavnu stranku vyberu hry
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
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          },
        ));
  }

  //Nastavenie text button, ktory sa po stlaceni dostane na hlavnu stranku vyberu hry
//textu nastavujeme pozadovane parametre a graficke prevedenie
  play(context) {
    return Container(
        margin: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.02,
            right: SizeConfig.screenWidth * 0.25),
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          child: Text('Hrát',
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 10,
              )),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlappyDuckScreen()),
            );
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
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SudokuScreen()),
            );
          },
        ));
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
            Navigator.pop(context),
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiProvider(providers: [
                      ChangeNotifierProvider(
                          create: (_) =>
                              ControllerFive()) //make controller accessible throughout the project
                    ], child: const VutrdleScreenFive()))),
          },
        ));
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
            Navigator.pop(context),
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            )
          },
        ));
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
        ));
  }
}
