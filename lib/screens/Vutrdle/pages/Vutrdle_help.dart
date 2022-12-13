import 'package:Halt/scale.dart';
import 'package:flutter/material.dart';

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
                mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              )),
        ));
  }
}
