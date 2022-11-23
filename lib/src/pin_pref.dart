import 'package:shared_preferences/shared_preferences.dart';

class PinPref {
  late SharedPreferences _pref;

  Future<void> init() async => _pref = await SharedPreferences.getInstance();

  void saveCode(String value) => _pref.setString("code", value);

  String get code => _pref.getString("code") ?? "";
}
