import 'package:flutter/material.dart';
import '../../data/models/note.dart';
import '../../data/repositories/note_repository.dart';

class NoteStore extends ChangeNotifier {
  final NoteRepository _repo;

  NoteStore(this._repo);

  List<Note> _notes = [];
  bool _loading = false;

  List<Note> get notes => _notes;
  bool get loading => _loading;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _notes = await _repo.getAll();

    _loading = false;
    notifyListeners();
  }

  Future<void> add(String title, String content) async {
    final now = DateTime.now();
    await _repo.insert(
      Note(
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
      ),
    );
    await load();
  }

  Future<void> remove(int id) async {
    await _repo.delete(id);
    await load();
  }
}