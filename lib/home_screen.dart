import 'package:flutter/material.dart';
import 'database.dart';
import 'cadastro_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final data = await DatabaseHelper().getFilmes();
    setState(() {
      _filmes = data;
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
    final filme = _filmes.firstWhere((filme) => filme['id'] == id);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroScreen(filme: filme),
      ),
    );
    _carregarFilmes(); // Recarrega a lista após a edição
  }

  void _removerFilme(int id) async {
    await DatabaseHelper().deleteFilme(id);
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
          return GestureDetector(
            onTap: () => _editarFilme(filme['id']), 
            onLongPress: () => _removerFilme(filme['id']), 
            child: Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        filme['url_cartaz'],
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image, size: 100, color: Colors.grey); 
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      filme['titulo'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text('Ano: ${filme['ano']}'),
                    SizedBox(height: 5),
                    Text('Direção: ${filme['direcao']}'),
                    SizedBox(height: 5),
                    Text(
                      'Resumo: ${filme['resumo']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text('Nota: ${filme['nota']}'),
                  ],
                ),
              ),
            ),
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