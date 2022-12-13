import 'package:Halt/scale.dart';
import 'package:Halt/screens/Settings/settings_logic.dart';
import 'package:Halt/screens/Vutrdle/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isTimerSwitched = false;

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
          padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
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
              SwitchListTile(
                  title: const Text("Časovač",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  value: _isTimerSwitched,
                  onChanged: (value) {
                    setState(() {
                      _isTimerSwitched = value;
                    });
                    SettingsData.saveTimerToggle(isToggled: _isTimerSwitched);
                  }),

              const Text(
                "AUTOŘI",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Text(
                "Kateřina Lojdová",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                "Andrea Michlíková",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                "Marek Špirka",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Text(
                "\nVUT FIT - ITU",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
