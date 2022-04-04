import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? sp;

  init() async {
    if (sp != null) return;
    sp = await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) async {
    if (sp == null) await init();
    return sp!.setString(key, value);
  }

  Future<String?> getString(String key) async {
    if (sp == null) await init();
    return sp!.getString(key);
  }

  Future<bool> remove(String key) async {
    if (sp == null) await init();
    return sp!.remove(key);
  }
}
