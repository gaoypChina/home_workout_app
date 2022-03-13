import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  int switchIndex = 0;
  final String _key = "theme";

  AdaptiveThemeMode selectedTheme = AdaptiveThemeMode.system;

  setTheme({required int index, required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_key, index);
    print("theme : " + index.toString());
    if (index == 0) {
      AdaptiveTheme.of(context).setLight();
    } else if (index == 1) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setSystem();
    }
    switchIndex = index;
    notifyListeners();
  }

  Future<AdaptiveThemeMode> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = prefs.getInt(_key) ?? 2;
    switchIndex = index;
    if (switchIndex == 0) {

      notifyListeners();
      return AdaptiveThemeMode.light;
    } else if (switchIndex == 1) {

      notifyListeners();
      return AdaptiveThemeMode.dark;
    } else {
      notifyListeners();
      return AdaptiveThemeMode.system;
    }
  }
}
