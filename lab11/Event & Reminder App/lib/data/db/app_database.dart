import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  static Future<Database> _init() async {
    final path = join(await getDatabasesPath(), 'event_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          color_hex TEXT,
          icon_key TEXT
        )
        ''');

        await db.execute('''
        CREATE TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          category_id INTEGER,
          event_date TEXT,
          start_time TEXT,
          end_time TEXT,
          status TEXT,
          priority INTEGER
        )
        ''');

        await db.execute('''
        CREATE TABLE reminders(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          event_id INTEGER,
          minutes_before INTEGER,
          remind_at TEXT,
          is_enabled INTEGER
        )
        ''');
      },
    );
  }
}