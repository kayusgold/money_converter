import "package:shared_preferences/shared_preferences.dart";

class SharedPreferencesService {
  static SharedPreferencesService _preferencesService;
  static SharedPreferences _preferences;

  static Future<SharedPreferencesService> getInstance() async {
    if (_preferencesService == null) {
      _preferencesService = SharedPreferencesService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _preferencesService;
  }

  SharedPreferences get sharedPreferences => _preferences;
}
