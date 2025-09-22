import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      backgroundColor: const Color(0xFF0D1B2A),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Projeto: Readed',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(height: 16),
            Text(
              'Integrantes:',
              style: TextStyle(color: Color(0xFFE0E1DD), fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '- Danillo',
              style: TextStyle(color: Color(0xFFE0E1DD), fontSize: 16),
            ),
            // Adicione outros nomes aqui
          ],
        ),
      ),
    );
  }
}
