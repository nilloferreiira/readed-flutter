import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/mock_data.dart';

class BookProvider extends ChangeNotifier {
  List<Book> _books = mockLivros
      .map(
        (l) => Book(
          id: l['id'],
          title: l['title'],
          authorId: l['authorId'],
          year: l['year'],
        ),
      )
      .toList();

  List<Book> get books => _books;

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void editBook(Book book) {
    final idx = _books.indexWhere((b) => b.id == book.id);
    if (idx != -1) {
      _books[idx] = book;
      notifyListeners();
    }
  }
}
