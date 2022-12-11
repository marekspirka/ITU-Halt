import 'package:Halt/screens/ChooseGame/main_screen.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    var time = const Duration(seconds: 2);
    Future.delayed(time, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainScreen();
          },
        ),
        (route) => false,
      );
    });

    super.initState;
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
          body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/pattern.png'),
              fit: BoxFit.cover),
        ),
        //Circle with background gradient
        child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xff3968E0),
                  Color(0xff1A0F8E),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            //Logo
            child: Center(
                child: Container(
                    height: height * 0.6, //height to 60% of screen height
                    width: width * 0.6, //width t 60% of screen width
                    child: Image.asset('assets/images/Logo.png')))),
      )),
    );
  }
}
