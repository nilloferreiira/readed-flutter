import 'package:flutter/material.dart';
// ...existing code...
import '../providers/author_provider.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';

class EditBookScreen extends StatefulWidget {
  const EditBookScreen({Key? key}) : super(key: key);

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  Book? _livro;
  String _title = '';
  int _year = DateTime.now().year;
  int? _authorId;
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Book) {
      _livro = args;
      _title = _livro!.title;
      _year = _livro!.year;
      _authorId = _livro!.authorId;
    }
  }

  void _saveEdit() {
    if (_livro == null || _authorId == null) {
      setState(() {
        _error = 'Preencha todos os campos';
      });
      return;
    }
    final editedBook = Book(
      id: _livro!.id,
      title: _title,
      authorId: _authorId!,
      year: _year,
    );
    Provider.of<BookProvider>(context, listen: false).editBook(editedBook);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_livro == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editar Livro')),
        body: const Center(
          child: Text(
            'Livro não encontrado',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Livro')),
      backgroundColor: const Color(0xFF0D1B2A),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _title,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Título',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1B263B),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o título' : null,
                onChanged: (value) => _title = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _year.toString(),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Ano',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1B263B),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o ano' : null,
                onChanged: (value) => _year = int.tryParse(value) ?? _year,
              ),
              const SizedBox(height: 16),
              Consumer<AuthorProvider>(
                builder: (context, authorProvider, child) {
                  return DropdownButtonFormField<int>(
                    value: _authorId,
                    decoration: InputDecoration(
                      labelText: 'Autor',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: const Color(0xFF1B263B),
                      border: OutlineInputBorder(),
                    ),
                    dropdownColor: const Color(0xFF1B263B),
                    items: authorProvider.authors.map((autor) {
                      return DropdownMenuItem<int>(
                        value: autor.id,
                        child: Text(
                          autor.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _authorId = value),
                    validator: (value) =>
                        value == null ? 'Selecione um autor' : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              if (_error != null)
                Text(_error!, style: const TextStyle(color: Colors.redAccent)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveEdit();
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
