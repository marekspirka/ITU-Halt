import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halt.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingPage(),
    );
  }
}


////////////////////////////////////////////DO TO///////////////////////////////////////////////////////
///2. Doplnit Help Navbar pre Hry - Spravene uz len doplnit pucky pre help
///3. Spravit hry
///4. Spravit nastavenia
///5. Vymysliet ako spravit to vypinanie hry no
////////////////////////////////////////////////////////////////////////////////////////////////////////