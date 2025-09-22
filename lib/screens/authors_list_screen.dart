import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/author_provider.dart';

class AuthorsListScreen extends StatelessWidget {
  const AuthorsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autores')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF3A86FF),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addAuthor');
        },
      ),
      body: Consumer<AuthorProvider>(
        builder: (context, authorProvider, child) {
          final authors = authorProvider.authors;
          return ListView.builder(
            itemCount: authors.length,
            itemBuilder: (context, index) {
              final autor = authors[index];
              return Card(
                color: const Color(0xFF1B263B),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    autor.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    autor.nationality,
                    style: const TextStyle(color: Color(0xFFE0E1DD)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/editAuthor',
                      arguments: autor,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
