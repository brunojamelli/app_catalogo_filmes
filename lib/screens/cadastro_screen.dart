import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/filme.dart';
import '../services/database.dart';

class CadastroScreen extends StatefulWidget {
  final Filme? filme;

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
  double _nota = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _tituloController.text = widget.filme!.titulo;
      _anoController.text = widget.filme!.ano.toString();
      _direcaoController.text = widget.filme!.direcao;
      _resumoController.text = widget.filme!.resumo;
      _nota = widget.filme!.nota;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.filme == null ? 'Adicionar Filme' : 'Editar Filme'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 20),
              Text('Nota:'),
              RatingBar.builder(
                initialRating: _nota,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 30,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _nota = rating;
                  });
                },
              ),
              SizedBox(height: 20),
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

  Future<void> _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      final filme = Filme(
        id: widget.filme?.id ?? 0,
        titulo: _tituloController.text,
        ano: int.parse(_anoController.text),
        direcao: _direcaoController.text,
        resumo: _resumoController.text,
        urlCartaz: widget.filme?.urlCartaz ?? '', // Mantém a URL existente ou gera uma nova
        nota: _nota,
      );

      final databaseService = DatabaseService();
      if (widget.filme == null) {
        await databaseService.insertFilme(filme);
      } else {
        await databaseService.updateFilme(filme);
      }

      Navigator.pop(context);
    }
  }
}