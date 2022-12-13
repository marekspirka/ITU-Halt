import 'dart:io';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';
import 'package:Halt/screens/Settings/settings.dart';
import 'package:Halt/screens/Vutrdle/pages/vutrdle.dart';
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';
import 'package:provider/provider.dart';

import '../Vutrdle/controller.dart';

class NavBarSudoku extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
      width: SizeConfig.screenWidth * 0.60,
      backgroundColor: Color(0xff361320).withOpacity(0.95),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            play(context),
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
          top: SizeConfig.screenHeight * 0.38,
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

vutrdle(context) {
  return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.01,
          right: SizeConfig.screenWidth * 0.09),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MultiProvider(providers: [
                    ChangeNotifierProvider(
                        create: (_) =>
                            Controller()) //make controller accessible throughout the project
                  ], child: VutrdleScreen()))),
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
      margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.03,
          left: SizeConfig.screenWidth * 0.02),
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
