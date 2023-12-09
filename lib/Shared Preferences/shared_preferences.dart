
import 'dart:convert';
import 'package:dashtanehunar/Utils/utils.dart';


class SharedPref {
  static const String _keyUser = 'Dastan-e-Hunar-vendor SharedPref';

  static Future<void> saveVendor(Map<String, dynamic> userModel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUser, jsonEncode(userModel));
  }  

  static Future<Map<String, dynamic>?> getVendor() async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = prefs.getString(_keyUser);
    if (customerJson != null) {
      final userMap = jsonDecode(customerJson);
      return userMap;
    }
    return null;
  }  
  
   static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }
}
