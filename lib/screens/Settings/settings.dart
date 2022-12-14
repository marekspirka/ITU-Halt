//created by Kateřina Lojdová - xlojdo00, Marek Špirka - xspirk01
// holds the main settings screen layout
import 'package:Halt/scale.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';

import 'package:Halt/scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../../globals.dart' as globals;
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';

// ANDY INSERT PROMENNA HERE ⬇️

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //instance of an audio player
  final player = AudioPlayer();
  // tells if music is played
  bool mute = false;
  // determines the value of timer toggle
  bool timer = false;
  int value = 0;
  Color _minutesTextColor = const Color.fromARGB(100, 255, 255, 255);
  Color _tileBackgroundColor = const Color.fromARGB(100, 64, 64, 64);

  void _showPicker(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: [
                  Text('5'),
                  Text('10'),
                  Text('15'),
                  Text('20'),
                  Text('25'),
                  Text('30'),
                ],
                onSelectedItemChanged: (int value) {
                  setState(() {
                    globals.userTime = value;
                  });
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halt.'),
        titleTextStyle: const TextStyle(fontSize: 35),
        centerTitle: true,
        backgroundColor: settingsDarkerBlue,
        elevation: 2,
        toolbarHeight: 60,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [settingsDarkBlue, settingsLightBlue])),
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
          decoration: BoxDecoration(
            color: settingsDarkerBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'NASTAVENÍ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              // onChanged -> callback which would notify us when it has been changed
              //timer toggle
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SwitchListTile(
                    title: const Text("Časovač",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    value: timer,
                    onChanged: (value) {
                      setState(() {
                        timer = value;
                        globalTimeSet();
                        Timer(Duration(minutes: globals.userTime - 1), () {
                          exit(0);
                        });
                      });
                      if (value == true) {
                        _minutesTextColor = Colors.white;
                        _tileBackgroundColor = wordleDarkGrey;
                      } else {
                        _minutesTextColor =
                            const Color.fromARGB(100, 255, 255, 255);
                        _tileBackgroundColor =
                            const Color.fromARGB(100, 64, 64, 64);
                        ;
                      }
                    }),
              ),
              // user input -> for how long shold the app be running
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _tileBackgroundColor,
                          ),
                          onPressed: () => _showPicker(context),
                          child: Text(
                            '${globals.userTime}',
                            style: TextStyle(
                                color: _minutesTextColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                      child: Text(
                        'minut',
                        style: TextStyle(
                          color: _minutesTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // music player toggle <- by Marek Špirka - xspirk01
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: SwitchListTile(
                    title: const Text("Hudba",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        )),
                    value: mute,
                    onChanged: (value) {
                      setState(() {
                        mute = value;
                      });
                      if (value == false) {
                        player.stop();
                      } else {
                        player.play(AssetSource('music/music.mp3'));
                      }
                    }),
              ),
              //authors
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: Text(
                  "AUTOŘI",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Kateřina Lojdová\nAndrea Michlíková\nMarek Špirka",
                  style: TextStyle(
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Text(
                  "VUT FIT - ITU",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void globalTimeSet() {
    DateTime now = DateTime.now();
    String myTime = DateFormat('mm:ss').format(now);
    globals.startTime = DateFormat('mm:ss').parse(myTime);

    globals.isTimeOn = true;
    globals.isTimeOff = true;
  }
}
