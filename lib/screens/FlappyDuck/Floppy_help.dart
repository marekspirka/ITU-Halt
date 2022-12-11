import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

class NavBarFlappyHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
        width: SizeConfig.screenWidth * 0.60,
        backgroundColor: Colors.black.withOpacity(0.8),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                First(context),
                Second(context),
                Third(context),
                Fourth(context),
                Fifth(context),
                Sixth(context),
              ],
            )));
  }
}

First(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.15),
    child: Text('Ako hrať túto hru?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 8,
        )),
  );
}

Second(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text(
        'Snažte sa udržať kachnu čo najdlhšie vo vzduchu a vyhýbajte sa prekážkam.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

Third(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text('Po kliknutí na kachnu sa hra spustí.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

Fourth(context) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    width: SizeConfig.screenWidth * 0.20,
    height: SizeConfig.screenHeight * 0.15,
    child: Image.asset('assets/icons/Bird.png'),
  );
}

Fifth(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
    child: Text('Snažte sa vyhýbať Brnenskému orloju.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

Sixth(context) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
    width: 300,
    height: 100,
    child: Image.asset('assets/images/barriers.png'),
  );
}
