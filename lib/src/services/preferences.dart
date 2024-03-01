import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _dayRouter = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get dayRouter {
    return _prefs.getString('dayRouter') ?? _dayRouter;
  }

  static set dayRouter(String dayRouter) {
    _dayRouter = dayRouter;
    _prefs.setString('dayRouter', dayRouter);
  }
  
  
}
