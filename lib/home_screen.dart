import 'package:flutter/material.dart';
import 'database.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Filmes'),
      ),
      body: ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          final filme = _filmes[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (filme['url_cartaz'] != null && filme['url_cartaz'].isNotEmpty)
                    Image.network(
                      filme['url_cartaz'],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image); 
                      },
                    ),
                  SizedBox(height: 10),
                  Text(
                    filme['titulo'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('Ano: ${filme['ano']}'),
                  SizedBox(height: 5),
                  Text('Direção: ${filme['direcao']}'),
                  SizedBox(height: 5),
                  Text('Resumo: ${filme['resumo']}'),
                  SizedBox(height: 5),
                  Text('Nota: ${filme['nota']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}