import 'package:emotion_tracker/infrastructure/storage/history_storage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database?> openSqfliteDatabase() async {
  String dbPath = await getDatabasesPath();
  final path = join(dbPath, "emotion_history.db");
  final db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(EmotionHistoryStorage.tableSql);
  });
  return db;
}
