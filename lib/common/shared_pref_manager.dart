import 'package:late_box_book/common/shared_pref_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  SharedPreferences _prefs;

  SharedPrefManager() {
    init();
  }

  void init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setTeam(String team) {
    _prefs.setString(SharedPrefConst.CURRENT_TEAM, team);
  }

  String getTeam() {
    return _prefs.getString(SharedPrefConst.CURRENT_TEAM);
  }
}
