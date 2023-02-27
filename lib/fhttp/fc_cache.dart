import 'package:shared_preferences/shared_preferences.dart';

class FcCache {
  SharedPreferences? prefs;

  FcCache._() {
    init();
  }

  static FcCache? _instance;

  FcCache._pre(SharedPreferences prefs) {
    this.prefs = prefs;
  }

  static Future<FcCache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = FcCache._pre(prefs);
    }
    return _instance!;
  }

  static FcCache getInstance() {
    if (_instance == null) {
      _instance = FcCache._();
    }
    return _instance!;
  }

  void init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}