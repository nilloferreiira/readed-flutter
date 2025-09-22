import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../providers/author_provider.dart';
import '../models/author.dart';

class BooksListScreen extends StatelessWidget {
  const BooksListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Estante')),
      body: Consumer2<BookProvider, AuthorProvider>(
        builder: (context, bookProvider, authorProvider, _) {
          final books = bookProvider.books;
          final authors = authorProvider.authors;
          return Stack(
            children: [
              ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final livro = books[index];
                  final autor = authors.firstWhere(
                    (a) => a.id == livro.authorId,
                    orElse: () =>
                        Author(id: 0, name: 'Desconhecido', nationality: ''),
                  );
                  return Card(
                    color: const Color(0xFF1B263B),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      title: Text(
                        livro.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        autor.name,
                        style: const TextStyle(color: Color(0xFFE0E1DD)),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/bookDetails',
                          arguments: livro,
                        );
                      },
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 24,
                left: 24,
                child: FloatingActionButton(
                  heroTag: 'profile',
                  backgroundColor: const Color(0xFF1B263B),
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.account_circle),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      heroTag: 'addBook',
                      backgroundColor: const Color(0xFF3A86FF),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, '/addBook');
                      },
                    ),
                    const SizedBox(height: 12),
                    FloatingActionButton(
                      heroTag: 'authors',
                      backgroundColor: const Color(0xFF1B263B),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.group),
                      onPressed: () {
                        Navigator.pushNamed(context, '/authorsList');
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
