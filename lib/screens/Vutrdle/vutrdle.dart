import 'package:Halt/screens/Vutrdle/NavBar_vutrdle.dart';
import 'package:flutter/material.dart';
import 'NavBar_vutrdle.dart';
import 'Vutrdle_help.dart';

class VutrdleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBarVutrdle(),
        endDrawer: NavBarVutrdleHelp(),
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
          backgroundColor: Color(0xff210a64),
          elevation: 2,
          toolbarHeight: 60,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff3c12b4),
                Color(0xff941397),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ));
  }
}
