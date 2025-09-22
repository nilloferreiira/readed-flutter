import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/author.dart';
import '../providers/author_provider.dart';

class EditAuthorScreen extends StatefulWidget {
  const EditAuthorScreen({Key? key}) : super(key: key);

  @override
  State<EditAuthorScreen> createState() => _EditAuthorScreenState();
}

class _EditAuthorScreenState extends State<EditAuthorScreen> {
  final _formKey = GlobalKey<FormState>();
  Author? _autor;
  String _name = '';
  String _nationality = '';
  String? _error;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Author) {
      _autor = args;
      _name = _autor!.name;
      _nationality = _autor!.nationality;
    }
  }

  void _saveEdit() {
    if (_autor == null || _name.isEmpty || _nationality.isEmpty) {
      setState(() {
        _error = 'Preencha todos os campos';
      });
      return;
    }
    final editedAuthor = Author(
      id: _autor!.id,
      name: _name,
      nationality: _nationality,
    );
    Provider.of<AuthorProvider>(
      context,
      listen: false,
    ).editAuthor(editedAuthor);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_autor == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editar Autor')),
        body: const Center(
          child: Text(
            'Autor não encontrado',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Autor')),
      backgroundColor: const Color(0xFF0D1B2A),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _name,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1B263B),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o nome' : null,
                onChanged: (value) => _name = value,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _nationality,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Nacionalidade',
                  labelStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: const Color(0xFF1B263B),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Informe a nacionalidade'
                    : null,
                onChanged: (value) => _nationality = value,
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
