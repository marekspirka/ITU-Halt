//created by Kateřina Lojdová - xlojdo00, Marek Špirka - xspirk01
// holds the main settings screen layout
import 'package:Halt/scale.dart';
import 'package:Halt/screens/Settings/settings_logic.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// ANDY INSERT PROMENNA HERE ⬇️

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // determines the value of timer toggle
  bool _isTimerSwitched = false;
  //instance of an audio player
  final player = AudioPlayer();
  // tells if music is played
  bool mute = false;
  Color _minutesTextColor = const Color.fromARGB(100, 255, 255, 255);
  Color _tileBackgroundColor = const Color.fromARGB(100, 64, 64, 64);

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
                    value: _isTimerSwitched,
                    onChanged: (value) async {
                      setState(() {
                        _isTimerSwitched = value;
                      });
                      SettingsData.saveTimerToggle(isToggled: _isTimerSwitched);
                      if (await SettingsData.getTimerToggle()) {
                        _minutesTextColor = Colors.white;
                        _tileBackgroundColor =
                            const Color.fromARGB(255, 64, 64, 64);
                      }
                    }),
              ),
              // user input -> for how long shold the app be running
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: _tileBackgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // ANDY INSERT PROMENNA HERE ⬇️
                          child: Text('5',
                              style: TextStyle(
                                color: _minutesTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center),
                        ),
                      ),
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
                padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
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
}
