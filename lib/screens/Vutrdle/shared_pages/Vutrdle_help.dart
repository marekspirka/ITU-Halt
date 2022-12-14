//created by Kateřina Lojdová - xlojdo00
// holds instructions on how to play the game
// lets the user chosse difficulty
import 'package:Halt/scale.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/controller_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_five/pages/vutrdle_five.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/controller_six.dart';
import 'package:Halt/screens/Vutrdle/vutrdle_six/pages/vutrdle_six.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBarVutrdleHelp extends StatelessWidget {
  const NavBarVutrdleHelp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
        width: 270,
        backgroundColor: const Color(0xff2a0c7d),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 15, 40),
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Jak se tato hra hraje?\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 8,
                    ),
                  ),
                  Text(
                    'Vaším cílem je správně uhodnout dané slovo na 6 pokusů',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001,
                            right: SizeConfig.screenHeight * 0.02),
                        width: SizeConfig.screenWidth * 0.20,
                        height: SizeConfig.screenHeight * 0.15,
                        child: Image.asset('assets/images/letter_green.png'),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001),
                        child: Text(
                            'dané písmeno se ve slově nachází přesně na této pozici',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001,
                            right: SizeConfig.screenHeight * 0.02),
                        width: SizeConfig.screenWidth * 0.20,
                        height: SizeConfig.screenHeight * 0.15,
                        child: Image.asset('assets/images/letter_yellow.png'),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001),
                        child: Text(
                            'dané písmeno se ve slově nachází na jiné pozici',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001,
                            right: SizeConfig.screenHeight * 0.02),
                        width: SizeConfig.screenWidth * 0.20,
                        height: SizeConfig.screenHeight * 0.15,
                        child: Image.asset('assets/images/letter_grey.png'),
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.4,
                        margin: EdgeInsets.only(
                            top: SizeConfig.screenHeight * 0.001),
                        child: Text('dané písmeno se v hádaném slově nenachází',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            )),
                      ),
                    ],
                  ),
                  Text(
                    '\nPočet písmen ve slově:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.safeBlockHorizontal * 6,
                    ),
                  ),
                  // play guessing 5-letter words
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: InkWell(
                      radius: 100,
                      onTap: () => {
                        Navigator.pop(context),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MultiProvider(providers: [
                                  ChangeNotifierProvider(
                                      create: (_) =>
                                          ControllerFive()) //make controller accessible throughout the project
                                ], child: const VutrdleScreenFive()))),
                      },
                      child: Image.asset('assets/images/five.png'),
                    ),
                  ),

                  // play guessing 6-letter words
                  SizedBox(
                    width: 200,
                    height: 30,
                    child: InkWell(
                      radius: 100,
                      onTap: () => {
                        Navigator.pop(context),
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MultiProvider(providers: [
                                  ChangeNotifierProvider(
                                      create: (_) =>
                                          ControllerSix()) //make controller accessible throughout the project
                                ], child: const VutrdleScreenSix()))),
                      },
                      child: Image.asset('assets/images/six.png'),
                    ),
                  ),
                ],
              )),
        ));
  }
}
