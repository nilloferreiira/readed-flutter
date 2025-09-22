import 'package:flutter/material.dart';
import '../models/author.dart';
import '../data/mock_data.dart';

class AuthorProvider extends ChangeNotifier {
  List<Author> _authors = mockAutores
      .map(
        (a) =>
            Author(id: a['id'], name: a['name'], nationality: a['nationality']),
      )
      .toList();

  List<Author> get authors => _authors;

  void addAuthor(Author author) {
    _authors.add(author);
    notifyListeners();
  }

  void editAuthor(Author author) {
    final idx = _authors.indexWhere((a) => a.id == author.id);
    if (idx != -1) {
      _authors[idx] = author;
      notifyListeners();
    }
  }
}
