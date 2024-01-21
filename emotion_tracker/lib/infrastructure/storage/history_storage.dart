import 'package:emotion_tracker/domain/emotion_record.dart';
import 'package:sqflite/sqflite.dart';

class EmotionHistoryStorage {
  final Database _db;

  static const String _tableName = 'emotion_history_storage';
  static const String _columnId = 'id';
  static const String _columnEmotion = 'emotion';
  static const String _columnCreateDate = 'create_date';

  static const String tableSql = '''
      CREATE TABLE IF NOT EXISTS $_tableName (
      $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnEmotion TEXT NOT NULL,
      $_columnCreateDate INTEGER NULL
    )
  ''';

  EmotionHistoryStorage(this._db);

  Future<int> insert(EmotionRecord emotionRecord) async {
    final todoID = await _db.insert(_tableName, emotionRecord.toMap());
    return todoID;
  }

  Future<List<EmotionRecord>?> getHistory() async {
    List<Map> maps = await _db.query(
      _tableName,
      columns: [_columnId, _columnEmotion, _columnCreateDate],
      orderBy: '$_columnCreateDate DESC',
    );
    final List<EmotionRecord> todoList = [];

    for (var i = 0; i < maps.length; i++) {
      todoList.add(EmotionRecord.fromMap(maps[i].cast()));
    }
    return todoList;
  }

  Future<int> delete(int id) async {
    return await _db
        .delete(_tableName, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future close() async => _db.close();
}
