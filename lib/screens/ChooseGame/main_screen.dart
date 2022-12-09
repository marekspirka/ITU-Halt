import 'package:flutter/material.dart';
import 'package:Halt/screens/ChooseGame/NavBar_main.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/vutrdle.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: new Text('Halt.'),
          titleTextStyle: TextStyle(fontSize: 35),
          centerTitle: true,
          backgroundColor: Color(0xff000075),
          elevation: 2,
          toolbarHeight: 60,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff1A0F8E),
                  Color(0xff3968E0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                sudoku_button(context),
                vutrdle_button(context),
                flappy_duck_button(context),
              ],
            )));
  }

  sudoku_button(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SudokuScreen()));
      },
      child: Container(
        height: SizeConfig.safeBlockVertical * 26,
        width: SizeConfig.safeBlockHorizontal * 80,
        margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 5),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 15),
              height: SizeConfig.safeBlockVertical * 25,
              width: SizeConfig.safeBlockHorizontal * 80,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 3.2,
                  horizontal: SizeConfig.safeBlockHorizontal * 21),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: Text(
                'SUDOKU',
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    ));
  }

  vutrdle_button(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => VutrdleScreen()));
      },
      child: Container(
        height: SizeConfig.safeBlockVertical * 26,
        width: SizeConfig.safeBlockHorizontal * 80,
        margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 5),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 15),
              height: SizeConfig.safeBlockVertical * 25,
              width: SizeConfig.safeBlockHorizontal * 80,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 3.2,
                  horizontal: SizeConfig.safeBlockHorizontal * 20),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: Text(
                'VUTRDLE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    ));
  }

  flappy_duck_button(BuildContext context) {
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FlappyDuckScreen()));
      },
      child: Container(
        height: SizeConfig.safeBlockVertical * 26,
        width: SizeConfig.safeBlockHorizontal * 80,
        margin: EdgeInsets.only(top: SizeConfig.safeBlockHorizontal * 5),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(bottom: SizeConfig.safeBlockVertical * 15),
              height: SizeConfig.safeBlockVertical * 25,
              width: SizeConfig.safeBlockHorizontal * 80,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 3.2,
                  horizontal: SizeConfig.safeBlockHorizontal * 10),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: Text(
                'FLAPPY DUCK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.safeBlockHorizontal * 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SizeConfig {
  late MediaQueryData _mediaQueryData;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double blockSizeHorizontal = 0.0;
  static double blockSizeVertical = 0.0;

  static double _safeAreaHorizontal = 0.0;
  static double _safeAreaVertical = 0.0;
  static double safeBlockHorizontal = 0.0;
  static double safeBlockVertical = 0.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
