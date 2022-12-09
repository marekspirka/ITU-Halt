import 'dart:math';
import 'package:Halt/screens/FlappyDuck/Floppy_help.dart';
import 'package:Halt/screens/FlappyDuck/NavBar_flappy.dart';
import 'package:Halt/screens/FlappyDuck/barriers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Halt/screens/FlappyDuck/Bird.dart';
import 'dart:async';

class FlappyDuckScreen extends StatefulWidget {
  @override
  State<FlappyDuckScreen> createState() => _FlappyDuckScreenState();
}

class _FlappyDuckScreenState extends State<FlappyDuckScreen> {
  static double BirdY = 0;
  double time = 0;
  double height = 0;
  double inHeaight = BirdY;
  bool gameStarted = false;
  static double BarrierX_one = 1;
  double BarrierX_two = BarrierX_one + 1;

  void jump() {
    setState(() {
      time = 0;
      inHeaight = BirdY;
    });
  }

  void GameStart() {
    gameStarted = true;
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        BirdY = inHeaight - height;
        BarrierX_one -= 0.1;
        BarrierX_two -= 0.1;
      });

      setState(() {
        if (BarrierX_one < -2) {
          BarrierX_one += 2.2;
        } else {
          BarrierX_one -= 0.05;
        }
      });

      setState(() {
        if (BarrierX_two < -2) {
          BarrierX_two += 2.2;
        } else {
          BarrierX_two -= 0.05;
        }
      });
      if (BirdY > 1) {
        timer.cancel();
        gameStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameStarted) {
          jump();
        } else {
          GameStart();
        }
      },
      child: Scaffold(
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
                child: Stack(
                  children: [
                    AnimatedContainer(
                      alignment: Alignment(0, BirdY),
                      duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: Bird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameStarted
                          ? Text(" ")
                          : Text("TAP TO PLAY",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierX_one, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierX_one, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(
                        size: 200.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierX_two, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(
                        size: 150.0,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(BarrierX_two, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: Barrier(
                        size: 150.0,
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
