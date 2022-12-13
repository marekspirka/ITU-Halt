import 'package:Halt/scale.dart';
import 'package:flutter/material.dart';

class NavBarSudokuHelp extends StatelessWidget {
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
                first(context),
                second(context),
                third(context),
                fourth(context),
                fifth(context),
                sixth(context),
                seventh(context),
              ],
            )));
  }
}

first(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.15),
    child: Text('Jak hrát hru?',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 8,
        )),
  );
}

second(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text('Vaším cílem je správně vyplnit tabulku.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

third(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text('Doplňte čísla 1-9  podle následujících pravidel:',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

fourth(context) {
  return Container(
    width: SizeConfig.screenWidth * 0.55,
    margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
    child: Text('2 stejná čísla nesmí být ve stejném sloupci, řádku, čtverci.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: SizeConfig.safeBlockHorizontal * 4,
        )),
  );
}

fifth(context) {
  return Container(
      width: SizeConfig.screenWidth * 0.55,
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/sudoku_column.png'),
        const Padding(padding: EdgeInsets.all(10)),
        Text('sloupci',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            )),
      ]));
}

sixth(context) {
  return Container(
      width: SizeConfig.screenWidth * 0.55,
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/sudoku_row.png'),
        const Padding(padding: EdgeInsets.all(10)),
        Text('řádku',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            )),
      ]));
}

seventh(context) {
  return Container(
      width: SizeConfig.screenWidth * 0.55,
      margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset('assets/images/sudoku_box.png'),
        const Padding(padding: EdgeInsets.all(10)),
        Text('čtverci',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            )),
      ]));
}
