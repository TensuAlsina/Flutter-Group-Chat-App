import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServecs {
  setIsUserLoggedIn({required bool isLogged}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogged", isLogged);
  }
}
