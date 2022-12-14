//created by Kateřina Lojdová - xlojdo00
// holds the main settings screen logic
import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  //saves the state of timer toggle
  static saveTimerToggle({required bool isToggled}) async {
    // add await because we are awaiting a future from getInstance()
    final timerToggle = await SharedPreferences.getInstance();
    timerToggle.setBool('isToggled', isToggled);
  }

  //fetch the state of timer toggle
  static Future<bool> getTimerToggle() async {
    final timerToggle = await SharedPreferences.getInstance();
    // ?? -> if null is passed, return false by default
    return timerToggle.getBool('isToggled') ?? false;
  }
}
