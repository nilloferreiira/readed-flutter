import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../providers/author_provider.dart';
import '../models/author.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final bookId = (args is Book) ? args.id : null;
    if (bookId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes do Livro')),
        body: const Center(
          child: Text(
            'Livro não encontrado',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Consumer2<BookProvider, AuthorProvider>(
      builder: (context, bookProvider, authorProvider, child) {
        final livro = bookProvider.books.firstWhere(
          (b) => b.id == bookId,
          orElse: () =>
              Book(id: 0, title: 'Não encontrado', authorId: 0, year: 0),
        );
        final autor = authorProvider.authors.firstWhere(
          (a) => a.id == livro.authorId,
          orElse: () => Author(id: 0, name: 'Desconhecido', nationality: ''),
        );
        return Scaffold(
          appBar: AppBar(title: Text(livro.title)),
          backgroundColor: const Color(0xFF0D1B2A),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título: ${livro.title}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Autor: ${autor.name}',
                  style: const TextStyle(
                    color: Color(0xFFE0E1DD),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ano: ${livro.year}',
                  style: const TextStyle(
                    color: Color(0xFFE0E1DD),
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/editBook',
                        arguments: livro,
                      );
                    },
                    child: const Text('Editar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
