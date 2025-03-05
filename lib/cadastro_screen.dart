import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'database.dart';

class CadastroScreen extends StatefulWidget {
  final Map<String, dynamic>? filme;

  CadastroScreen({this.filme});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _anoController = TextEditingController();
  final _direcaoController = TextEditingController();
  final _resumoController = TextEditingController();
  double _nota = 3;

  // Lista de URLs de cartazes
  final List<String> _cartazes = [
    'https://image.tmdb.org/t/p/w500/rPdtL9s8cUROZK1hRflLQ9f7VnW.jpg', // O Poderoso Chefão
    'https://image.tmdb.org/t/p/w500/8ZBY6YR9QYVDWX4Z3zQvJz4ZzZz.jpg', // O Senhor dos Anéis
    'https://image.tmdb.org/t/p/w500/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg', // Interestelar
    'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg', // Outro filme
    'https://image.tmdb.org/t/p/w500/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg', // Outro filme
    'https://image.tmdb.org/t/p/w500/1Lh9LER4xRQ3INFFi2dfS2hpRwv.jpg', // Outro filme
    'https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg', // Outro filme
  ];

  // Método para selecionar uma URL aleatória
  String _getRandomPoster() {
    final random = DateTime.now().millisecondsSinceEpoch % _cartazes.length;
    return _cartazes[random];
  }

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _tituloController.text = widget.filme!['titulo'];
      _anoController.text = widget.filme!['ano'].toString();
      _direcaoController.text = widget.filme!['direcao'];
      _resumoController.text = widget.filme!['resumo'];
      _nota = widget.filme!['nota'].toDouble();
    }
  }

  void _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      final filme = {
        'titulo': _tituloController.text,
        'ano': int.parse(_anoController.text),
        'direcao': _direcaoController.text,
        'resumo': _resumoController.text,
        'url_cartaz': _getRandomPoster(), // Atribui uma URL aleatória
        'nota': _nota.round(),
      };

      if (widget.filme != null) {
        filme['id'] = widget.filme!['id'];
        await DatabaseHelper().updateFilme(filme);
      } else {
        await DatabaseHelper().insertFilme(filme);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Filme salvo com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filme == null ? 'Adicionar Filme' : 'Editar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: 'Ano'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o ano';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _direcaoController,
                decoration: InputDecoration(labelText: 'Direção'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a direção';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _resumoController,
                decoration: InputDecoration(labelText: 'Resumo'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o resumo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              RatingBar.builder(
                initialRating: _nota,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  setState(() {
                    _nota = rating;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _salvarFilme,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

