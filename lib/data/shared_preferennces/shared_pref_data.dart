import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/repository/shared_pref_repository.dart';

class SharedPrefData implements SharedPrefRepository {
  @override
  Future<String?> getLogin() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString("login");
  }

  @override
  Future<String?> removeLogin() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    await sharedPref.remove("login");
    return null;
  }

  @override
  Future<String?> saveLogin({required String token}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("login", token);
    return null;
  }
}
