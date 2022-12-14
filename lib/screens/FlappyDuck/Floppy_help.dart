/**
 * Creator Marek Spirka
 */
import 'package:flutter/material.dart';
import 'package:Halt/scale.dart';

/**
 * V tomto subore sa vytvare help menu pre uzivatele ako hrat danu hru
 * Okno sa vytvori a graficky nastavi na pozadovany styl
 */
class NavBarFlappyHelp extends StatelessWidget {
  const NavBarFlappyHelp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
        width: SizeConfig.screenWidth * 0.60,
        backgroundColor: Colors.black.withOpacity(0.8),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              //volanie funkcii, ktore nam tvoria cely HelpBar
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

/**
 * Funkcie, ktore vracaju text alebo obrazok do HelpBar hru Floppy duck
 * nastavujeme tam velkost podla scale a farbu daneho textu 
 */

First(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.15),
    child: Text('Jak hrát?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 8,
        )),
  );
}

Second(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.50,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text(
        'Snažte se kachničku udržet co nejdéle ve vzduchu a vyhýbejte se překážkám.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

Third(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.50,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text('Po kliknutí na kachničku se hra spustí.',
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
    child: Text('Snažte se vyhýbat Brněnskému orloji.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

Sixth(context) {
  return Container(
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.07),
    width: 300,
    height: 100,
    child: Image.asset('assets/images/barriers.png'),
  );
}
