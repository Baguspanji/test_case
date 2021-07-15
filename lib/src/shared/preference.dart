import 'package:shared_preferences/shared_preferences.dart';

Future setUser(List<String> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setStringList("userGoogle", value);
}

Future getUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getStringList("userGoogle");
}

Future rmvUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("userGoogle");
}
