import 'package:flutter/material.dart';
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter está inicializado
  final dbHelper = DatabaseHelper();

  // Recuperar e exibir os filmes no console
  final filmes = await dbHelper.getFilmes();
  print('Filmes pré-inseridos:');
  filmes.forEach((filme) {
    print('Título: ${filme['titulo']}');
    print('Ano: ${filme['ano']}');
    print('Direção: ${filme['direcao']}');
    print('Resumo: ${filme['resumo']}');
    print('URL do Cartaz: ${filme['url_cartaz']}');
    print('Nota: ${filme['nota']}');
    print('---');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Meus Filmes'),
        ),
        body: Center(
          child: Text('Banco de dados configurado com sucesso!'),
        ),
      ),
    );
  }
}