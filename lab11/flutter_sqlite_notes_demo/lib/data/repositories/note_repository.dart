import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/note.dart';

class NoteRepository {
  static const table = 'notes';

  Future<int> insert(Note note) async {
    final db = await AppDatabase.instance.database;
    return db.insert(
      table,
      note.toMap()..remove('id'),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getAll() async {
    final db = await AppDatabase.instance.database;
    final rows =
        await db.query(table, orderBy: 'updated_at DESC');
    return rows.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> update(Note note) async {
    final db = await AppDatabase.instance.database;
    return db.update(
      table,
      note.toMap()..remove('created_at'),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance.database;
    return db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}