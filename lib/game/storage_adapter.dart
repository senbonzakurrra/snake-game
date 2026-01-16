import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game/game/logic_game.dart';

class StorageAdapter {
  static const _keySpeed = 'speed';
  static const _keyRecord = 'record';

  static void setSpeed(double speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keySpeed, speed);
  }

  static void setRecord(int record) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyRecord, record);
  }

  static Future<double> getSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_keySpeed) ?? SnakeGame.gameSpeed;
  }

  static Future<int> getRecord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyRecord) ?? 0;
  }
}
