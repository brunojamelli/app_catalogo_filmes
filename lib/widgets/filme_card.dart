import 'package:flutter/material.dart';
import '../models/filme.dart';

class FilmeCard extends StatelessWidget {
  final Filme filme;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const FilmeCard({
    required this.filme,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  filme.urlCartaz,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.broken_image, size: 100, color: Colors.grey);
                  },
                ),
              ),
              SizedBox(height: 10),
              Text(
                filme.titulo,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text('Ano: ${filme.ano}'),
              SizedBox(height: 5),
              Text('Direção: ${filme.direcao}'),
              SizedBox(height: 5),
              Text(
                'Resumo: ${filme.resumo}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text('Nota: ${filme.nota}'),
            ],
          ),
        ),
      ),
    );
  }
}