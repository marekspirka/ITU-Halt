import 'package:flutter/material.dart';
import 'package:Halt/screens/ChooseGame/NavBar_main.dart';
import 'package:Halt/screens/Sudoku/sudoku.dart';
import 'package:Halt/screens/Vutrdle/vutrdle.dart';
import 'package:Halt/screens/FlappyDuck/flappyduck.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
        child: InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SudokuScreen()));
      },
      child: Container(
        height: screenHeight * 0.2,
        width: screenWidth * 0.8,
        margin: const EdgeInsets.only(top: 60),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 120),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 99),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: const Text(
                'SUDOKU',
                style: TextStyle(
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
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 120),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 90),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: const Text(
                'VUTRDLE',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
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
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/images/pattern.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(22.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 120),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(vertical: 23, horizontal: 45),
              decoration: const BoxDecoration(
                  color: Color(0xff000075),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22.0),
                      topRight: Radius.circular(22.0))),
              child: const Text(
                'FLAPPY DUCK',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 1,
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
