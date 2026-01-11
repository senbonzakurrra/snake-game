import 'package:shared_preferences/shared_preferences.dart';
import 'package:snake_game/game/logic_game.dart';

class StorageAdapter {
  static const keySpeed = 'speed';
  static const keyRecord = 'record';

  void setSpeed(int speed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keySpeed, speed);
  }

  void setRecord(int record) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(keyRecord, record);
  }

  Future<int> getSpeed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keySpeed) ?? SnakeGame.gameSpeed;
  }

  Future<int> getRecord() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyRecord) ?? 0;
  }
}
