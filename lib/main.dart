import 'package:flutter/material.dart';
import 'screens/loading_screen.dart';
import 'globals.dart' as globals;

void main() {
  globals.isGlobal = true;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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