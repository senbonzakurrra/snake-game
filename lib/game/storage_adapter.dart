import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game/game/logic_game.dart';

class StorageAdapter {
  static const keySpeed = 'speed';
  static const keyRecord = 'record';

  static void setSpeed(double speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(keySpeed, speed);
  }

  static void setRecord(int record) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyRecord, record);
  }

  static Future<double> getSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(keySpeed) ?? SnakeGame.gameSpeed;
  }

  static Future<int> getRecord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyRecord) ?? 0;
  }
}
