import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setAuthenticationModelString(String value) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setString("authenticationModel", value);
  }

  Future<bool> setIsNewDeviceString(String value) async {
    return await _prefs.setString("device", value);
  }
  Future<bool> setLanguage(bool value) async {
    return await _prefs.setBool("language", value);
  }



  String? getIsNewDeviceString() {
    return _prefs.getString("device");
  }

  String? getAuthenticationModelString() {
    return _prefs.getString("authenticationModel");
  }  
  
  bool? getLanguage() {
    return _prefs.getBool("language");
  }

  Future<void> removeUser() async {
    await _prefs.remove("authenticationModel");
  }
}
