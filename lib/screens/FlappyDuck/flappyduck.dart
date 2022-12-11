import 'dart:async';
import 'package:Halt/screens/FlappyDuck/Floppy_help.dart';
import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:Halt/screens/FlappyDuck/NavBar_flappy.dart';
import 'package:Halt/screens/FlappyDuck/barriers.dart';
import 'package:Halt/screens/FlappyDuck/barries_upsidedown.dart';
import 'package:flutter/material.dart';
import 'package:Halt/screens/FlappyDuck/Bird.dart';
import 'package:Halt/screens/FlappyDuck/background.dart';
import 'package:Halt/scale.dart';

class FlappyDuckScreen extends StatefulWidget {
  State<FlappyDuckScreen> createState() => _FlappyDuckScreenState();
}

class _FlappyDuckScreenState extends State<FlappyDuckScreen> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStarted = false;
  String twoDigits(int n) => n.toString().padLeft(2, '0');

  double firstBarrier = 1.8;
  double secondBarrier = 1.8 + 1.5;
  double thirdBarrier = 1.8 + 3;
  bool StartGame = false;
  int score = 0;
  int highscore = 0;

  @override
  void initState() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      firstBarrier = 1.8;
      secondBarrier = 1.8 + 1.5;
      thirdBarrier = 1.8 + 3;
      StartGame = false;
      score = 0;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  bool checkLose() {
    if (firstBarrier < 0.2 && firstBarrier > -0.2) {
      if (birdYaxis < -0.4 || birdYaxis > 0.7) {
        return true;
      }
    }
    if (secondBarrier < 0.2 && secondBarrier > -0.2) {
      if (birdYaxis < -0.1 || birdYaxis > 0.4) {
        return true;
      }
    }
    if (thirdBarrier < 0.2 && thirdBarrier > -0.2) {
      if (birdYaxis < -0.6 || birdYaxis > 0.4) {
        return true;
      }
    }
    return false;
  }

  void GameStart() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        if (firstBarrier < -2) {
          score++;
          firstBarrier += 4.5;
        } else {
          firstBarrier -= 0.04;
        }
        if (secondBarrier < -2) {
          score++;
          secondBarrier += 4.5;
        } else {
          secondBarrier -= 0.04;
        }
        if (thirdBarrier < -2) {
          score++;
          thirdBarrier += 4.5;
        } else {
          thirdBarrier -= 0.04;
        }
      });
      if (birdYaxis > 1.3 || checkLose()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            child: Container(
              height: SizeConfig.safeBlockVertical * 35,
              width: SizeConfig.safeBlockHorizontal * 80,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      Text(
                        "KONEC",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 8,
                            color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 4,
                      ),
                      Text(
                        "Aktuálne skóre :           " + score.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 3,
                      ),
                      Text(
                        "Najvyššie skóre :           " + highscore.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth * 0.09,
                          0,
                          SizeConfig.screenWidth * 0.05,
                          0),
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "MENU",
                              style: TextStyle(
                                  color: Color(0xff6BC7EE),
                                  fontSize: SizeConfig.safeBlockHorizontal * 8),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            },
                          ),
                          SizedBox(width: SizeConfig.safeBlockHorizontal * 3.3),
                          TextButton(
                            child: Text(
                              "ZNOVU",
                              style: TextStyle(
                                  color: Color(0xff00FF29),
                                  fontSize: SizeConfig.safeBlockHorizontal * 8),
                            ),
                            onPressed: () {
                              if (score > highscore) {
                                highscore = score;
                              }
                              initState();
                              setState(() {
                                gameHasStarted = false;
                              });
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    )),
              ]),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
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
                    Brno(),
                    AnimatedContainer(
                      alignment: Alignment(0, birdYaxis),
                      duration: Duration(milliseconds: 0),
                      child: Bird(),
                    ),
                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted
                          ? Text(" ")
                          : Text("T A P  T O  P L A Y",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(firstBarrier, 1.1), //prva spodna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: SizeConfig.blockSizeVertical * 42,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(secondBarrier, 1.1), //druha spodna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: SizeConfig.blockSizeVertical * 30,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(thirdBarrier, 1.1), //tretia spodna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: SizeConfig.blockSizeVertical * 45,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(firstBarrier, -1.1), //prva horna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier_upsidedown(
                        size: SizeConfig.blockSizeVertical * 30,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(secondBarrier, -1.1), //druha horna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier_upsidedown(
                        size: SizeConfig.blockSizeVertical * 45,
                      ),
                    ),
                    AnimatedContainer(
                      alignment: Alignment(thirdBarrier, -1.1), //tretia horna
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier_upsidedown(
                        size: SizeConfig.blockSizeVertical * 25,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
