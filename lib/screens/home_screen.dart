import 'package:flutter/material.dart';
import '../services/database.dart';
import '../models/filme.dart';
import '../widgets/filme_card.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  List<Filme> _filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final filmes = await _databaseService.getFilmes();
    setState(() {
      _filmes = filmes;
    });
  }

  void _navegarParaCadastro() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CadastroScreen()),
    );
    _carregarFilmes();
  }

  void _editarFilme(int id) async {
    final filme = _filmes.firstWhere((filme) => filme.id == id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroScreen(filme: filme),
      ),
    );
    _carregarFilmes();
  }

  void _removerFilme(int id) async {
    await _databaseService.deleteFilme(id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Filme removido com sucesso!')),
    );
    _carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Filmes'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.6,
        ),
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          final filme = _filmes[index];
          return FilmeCard(
            filme: filme,
            onTap: () => _editarFilme(filme.id),
            onLongPress: () => _removerFilme(filme.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaCadastro,
        child: Icon(Icons.add),
      ),
    );
  }
}