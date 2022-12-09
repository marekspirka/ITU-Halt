import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Halt.'),
        titleTextStyle: TextStyle(fontSize: 35),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Container(
        color: Colors.blueAccent,
      ),
    );
  }
}
