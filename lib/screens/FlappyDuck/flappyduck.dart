import 'package:Halt/screens/FlappyDuck/Floppy_help.dart';
import 'package:Halt/screens/FlappyDuck/NavBar_flappy.dart';
import 'package:flutter/material.dart';
import 'package:Halt/screens/FlappyDuck/Bird.dart';

class FlappyDuckScreen extends StatefulWidget {
  @override
  State<FlappyDuckScreen> createState() => _FlappyDuckScreenState();
}

class _FlappyDuckScreenState extends State<FlappyDuckScreen> {
  double BirdY = 0;

  void jump() {
    setState(() {
      BirdY -= 0.1;
    });
  }

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
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
                onTap: jump,
                child: AnimatedContainer(
                  alignment: Alignment(0, BirdY),
                  duration: const Duration(milliseconds: 0),
                  color: Colors.blue,
                  child: Bird(),
                )),
          ),
          Expanded(
            child: Container(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
