import 'package:onroad/models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  CacheManager._();

  static CacheManager? _instance;

  static CacheManager? getInstance() {
    _instance ??= CacheManager._();
    return _instance!;
  }

  late SharedPreferences _sharedPreferences;

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  Future setChannelId(String ChannelId) async {
    await _sharedPreferences.setString("ChannelId", ChannelId);
  }
  String? getChannelId() {
    return _sharedPreferences.getString("ChannelId") !=null?_sharedPreferences.getString("ChannelId")!:null;
  }
  Future setNotificationSound(String NotificationSound) async {
    await _sharedPreferences.setString("NotificationSound", NotificationSound);
  }
  String getNotificationSound() {
    return _sharedPreferences.getString("NotificationSound") !=null?_sharedPreferences.getString("NotificationSound")!:'notification';
  }
  Future setLanguage(String Language) async {
    await _sharedPreferences.setString("Language", Language);
  }

  Future<String?> getLanguage() async {
    if (_sharedPreferences.getString("Language") != null) {
      return _sharedPreferences.getString("Language")!;
    } else {
      await setLanguage('AR');
      return _sharedPreferences.getString("Language")!;
    }
  }

  Future storeOrderData(dynamic orderId) async {

    await _sharedPreferences.setString("orderdata", orderId.toString());
  }

  String getOrderData() {
    return _sharedPreferences.getString("orderdata")!;
  }

  Future storeUserData(UserData data) async {
    await _sharedPreferences.setString("userdata", data.toString());
  }

  UserData getUserData() {
    return UserData.fomString(_sharedPreferences.getString("userdata")!);
  }

  bool isLoggedIn() {
    if (_sharedPreferences.getString("userdata") != null) {
      return true;
    }
    return false;
  }

  bool isAnyOrder() {
    if (_sharedPreferences.getString("orderdata") != null) {
      return true;
    }
    return false;
  }

  Future orderDone() async {
    await _sharedPreferences.remove("orderdata");
  }

  Future logout() async {
    await _sharedPreferences.remove("userdata");
  }
}
