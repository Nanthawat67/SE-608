import 'package:flutter/material.dart';

class CategoryStore extends ChangeNotifier {
  List<String> categories = [];

  void add(String name) {
    categories.add(name);
    notifyListeners();
  }
}