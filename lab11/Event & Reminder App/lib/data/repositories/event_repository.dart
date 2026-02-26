import '../db/app_database.dart';
import '../models/event.dart';

class EventRepository {
  Future<int> insert(Event event) async {
    final db = await AppDatabase.database;
    return await db.insert('events', event.toMap());
  }

  Future<List<Event>> getAll() async {
    final db = await AppDatabase.database;
    final maps = await db.query('events');
    return maps.map((e) => Event.fromMap(e)).toList();
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase.database;
    await db.delete('events', where: 'id=?', whereArgs: [id]);
  }
}