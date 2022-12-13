import 'package:shared_preferences/shared_preferences.dart';

class SettingsData {
  static saveTimerToggle({required bool isToggled}) async {
    // add await because we are awaiting a future from getInstance()
    final timerToggle = await SharedPreferences.getInstance();
    timerToggle.setBool('isToggled', isToggled);
  }

  static Future<bool> getTimerToggle() async {
    final timerToggle = await SharedPreferences.getInstance();
    // ?? -> if null is passed, return false by default
    return timerToggle.getBool('isToggled') ?? false;
  }
}
