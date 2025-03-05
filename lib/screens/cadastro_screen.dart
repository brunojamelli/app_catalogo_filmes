import 'package:flutter/material.dart';
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
  final _urlCartazController = TextEditingController();
  final _notaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _tituloController.text = widget.filme!.titulo;
      _anoController.text = widget.filme!.ano.toString();
      _direcaoController.text = widget.filme!.direcao;
      _resumoController.text = widget.filme!.resumo;
      _urlCartazController.text = widget.filme!.urlCartaz;
      _notaController.text = widget.filme!.nota.toString();
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
              TextFormField(
                controller: _urlCartazController,
                decoration: InputDecoration(labelText: 'URL do Cartaz'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL do cartaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notaController,
                decoration: InputDecoration(labelText: 'Nota'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a nota';
                  }
                  return null;
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
        urlCartaz: _urlCartazController.text,
        nota: double.parse(_notaController.text),
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