import 'package:Halt/scale.dart';
import 'package:flutter/material.dart';

class NavBarVutrdleHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Drawer(
        width: 270,
        backgroundColor: Color(0xff2a0c7d),
        child: Container(
          alignment: Alignment.center,
        ));
  }
}
