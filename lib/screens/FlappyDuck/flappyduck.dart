import 'package:Halt/screens/FlappyDuck/Floppy_help.dart';
import 'package:Halt/screens/FlappyDuck/NavBar_flappy.dart';
import 'package:flutter/material.dart';

class FlappyDuckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarFlappy(),
        endDrawer: NavBarFlappyHelp(),
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
          backgroundColor: Colors.black,
          elevation: 2,
          toolbarHeight: 60,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff79ebe1),
                Color(0xff79ebe1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ));
  }
}
