import 'package:shared_preferences/shared_preferences.dart';

class FromSharedPref {
  Future<String> getString(String data) async {
    String value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey(data)) {
      value = await pref.getString(data);
    }
    return value;
  }
}
