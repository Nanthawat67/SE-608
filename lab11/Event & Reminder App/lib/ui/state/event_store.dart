import 'package:flutter/material.dart';
import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

class EventStore extends ChangeNotifier {
  final _repo = EventRepository();
  List<Event> events = [];

  Future<void> load() async {
    events = await _repo.getAll();
    notifyListeners();
  }

  Future<void> add(Event event) async {
    if (event.endTime.compareTo(event.startTime) <= 0) {
      throw Exception("End time must be after start time");
    }
    await _repo.insert(event);
    await load();
  }

  Future<void> remove(int id) async {
    await _repo.delete(id);
    await load();
  }
}