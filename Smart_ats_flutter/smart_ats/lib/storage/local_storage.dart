import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUser(
      String ref, String name, String email, String password) async {
    // Added password
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userRef", ref);
    prefs.setString("name", name);
    prefs.setString("email", email);
    prefs.setString("password", password); // Save password
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "userRef": prefs.getString("userRef"),
      "name": prefs.getString("name"),
      "email": prefs.getString("email"),
      "password":
          prefs.getString("password"), // Return password.  You might not want to return this.
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
