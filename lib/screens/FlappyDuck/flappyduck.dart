/**
 * Creator Marek Spirka
 */
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
  //deklarovanie premmenych pre celu hru
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

  //inicializovanie zaciatku hry
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

  //funkcia na skakanie s kackou
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  //funkcia, ktora nam kontroluje dotyk s barierou ak sa dotkneme bariery funkcia vrati true
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

  //funkcia, ktora spusta zaciatok hry a skonci sa ak vyjdeme s kackou mimo obrazovku alebo sa dotkneme bariery
  void GameStart() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
        //urcuje nam, ze ak sa bariera dostane na lavy okraj obrazovky presunieme ju na pravu stranu, takto sa to prevadza aj s dalsimi 2 barierami
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
      //ak vyjdeme von z obrazovky alebo sa dotkneme bariery ukaze sa nam dialog okno so statistikami
      if (birdYaxis > 1.3 || checkLose()) {
        timer.cancel();
        _showDialog();
      }
    });
  }

  //dialog okno pri ukonceni hry
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black
                .withOpacity(0.8), //nastavenie background color dialogu
            child: Container(
              height:
                  SizeConfig.safeBlockVertical * 35, //nastavenie vysky so scale
              width: SizeConfig.safeBlockHorizontal *
                  80, //nastavenie sirky so scale
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
                        "Aktuálne skóre :           " +
                            score
                                .toString(), //aktulne skore, ktore sme ziskali v danej hre
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
                        "Najvyššie skóre :           " +
                            highscore
                                .toString(), //najvyssie skore, ktore sme dosiahli pri hrani hry, pri odideni s hry sa resetuje na 0
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                //inicializovanie a nastavenie vzhladu tlacidiel na odidenie z hry alebo restartovanie hry
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
                                  color: const Color(0xff6BC7EE),
                                  fontSize: SizeConfig.safeBlockHorizontal * 8),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MainScreen()));
                            },
                          ),
                          SizedBox(width: SizeConfig.safeBlockHorizontal * 3.3),
                          TextButton(
                            child: Text(
                              "ZNOVU",
                              style: TextStyle(
                                  color: const Color(0xff00FF29),
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

  //nastavenie hlavnej vizualnej casti hry a volanie vsetkych potrebnych funkcii
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //na tapnutie na obrazovku sa bud hra zacne alebo ak sa uz zacala tak sa vykonava funckia jump
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          GameStart();
        }
      },
      child: Scaffold(
        //otvorenie pomocky ako hrat danu hru
        drawer: const NavBarFlappy(),
        endDrawer: const NavBarFlappyHelp(),
        //otvorenie MenuBar aplikacie
        appBar: AppBar(
          actions: [
            Builder(
                builder: (context) => IconButton(
                    icon: Icon(Icons.question_mark_outlined),
                    onPressed: () => Scaffold.of(context).openEndDrawer())),
          ],
          title: new Text('Halt.'),
          titleTextStyle: const TextStyle(fontSize: 35),
          centerTitle: true,
          backgroundColor: Colors.black,
          elevation: 2,
          toolbarHeight: 60,
        ),
        body: Column(
          //vizualna cast stranky
          children: [
            Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    //volanie background funkcie
                    const background(),
                    AnimatedContainer(
                      //nastavenie kachny na vychodziu poziciu
                      alignment: Alignment(0, birdYaxis),
                      duration: const Duration(milliseconds: 0),
                      child: Bird(),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.3),
                      child: gameHasStarted
                          ? const Text(" ")
                          : Text("Š T A R T",
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 8,
                                  color: Colors.white)),
                    ),
                    //nastavenie vysky/sirky vsetkych barier
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
